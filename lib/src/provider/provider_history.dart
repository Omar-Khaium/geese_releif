import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/model/user.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/util/helper.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:geesereleif/src/model/history.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/network_helper.dart';

class HistoryProvider extends ChangeNotifier {
  Map<String, History> items = HashMap<String, History>();
  bool isLoading = true;
  User user;
  Box<User> userBox;

  init() {
    userBox = Hive.box("users");
    user = userBox.getAt(0);
  }

  List<History> get getAllHistories {
    List<History> _list = [];

    items.forEach((key, value) {
      _list.add(value);
    });

    _list.sort((a, b) => stringToDateTime(b.dateTime)
        .millisecondsSinceEpoch
        .compareTo(stringToDateTime(a.dateTime).millisecondsSinceEpoch));
    _list = parseHistory(_list);
    if (_list.length > 0) {
      if (_list[0].logType == LogType.CheckedIn) {
        _list[0].logType = LogType.Active;
      }
    }
    return _list;
  }

  History findHistoryByID(String time) =>
      items.containsKey(time) ? items[time] : null;

  Future<void> getHistory(CustomerProvider customerProvider) async {
    try {
      items = {};
      Map<String, String> headers = {
        "Authorization": user.token,
        "UserId": user.guid,
      };

      Response response =
          await NetworkHelper.apiGET(api: apiHistory, headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(
            json.decode(response.body)["CustomerDetail"].toList());
        result.forEach((historyItem) {
          List<Map<String, dynamic>> customerList =
              List<Map<String, dynamic>>.from(historyItem["GeeseCustomerList"]);
          customerList.forEach((customerItem) {
            Customer customer = Customer.fromJson(
              Map<String, dynamic>.from(customerItem),
              List<Map<String, dynamic>>.from(historyItem["GeeseMediaList"]),
              List<Map<String, dynamic>>.from(historyItem["GeeseNoteList"]),
              customerItem["RouteId"],
            );

            if (!customerProvider.customers.containsKey(customer.guid)) {
              customerProvider.customers[customer.guid] = customer;
            }
            History checkInHistory = History(
              customer: customer,
              dateTime: refineUTC(
                  customerItem["CheckInTime"].toString().contains(".")
                      ? customerItem["CheckInTime"]
                      : "${customerItem["CheckInTime"]}.000",
                  "yyyy-MM-dd'T'HH:mm:ss.SSS"),
              logType: LogType.CheckedIn,
            );
            History checkOutHistory = History(
              customer: customer,
              dateTime: refineUTC(
                  customerItem["CheckOutTime"].toString().contains(".")
                      ? customerItem["CheckOutTime"]
                      : "${customerItem["CheckOutTime"]}.000",
                  "yyyy-MM-dd'T'HH:mm:ss.SSS"),
              logType: LogType.CheckedOut,
            );
            items[checkInHistory.dateTime] = checkInHistory;
            items[checkOutHistory.dateTime] = checkOutHistory;
          });
        });
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshHistory(CustomerProvider customerProvider) async {
    isLoading = true;
    items = {};
    notifyListeners();
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "UserId": user.guid,
      };

      Response response =
          await NetworkHelper.apiGET(api: apiHistory, headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(
            json.decode(response.body)["CustomerDetail"].toList());
        result.forEach((historyItem) {
          List<Map<String, dynamic>> customerList =
              List<Map<String, dynamic>>.from(historyItem["GeeseCustomerList"]);
          customerList.forEach((customerItem) {
            Customer customer = Customer.fromJson(
              customerItem,
              historyItem["GeeseMediaList"],
              historyItem["GeeseNoteList"],
              customerItem["RouteId"],
            );

            if (!customerProvider.customers.containsKey(customer.guid)) {
              customerProvider.customers[customer.guid] = customer;
            }
            History checkInHistory = History(
              customer: customer,
              dateTime: refineUTC(
                  customerItem["CheckInTime"].toString().contains(".")
                      ? customerItem["CheckInTime"]
                      : "${customerItem["CheckInTime"]}.000",
                  "yyyy-MM-dd'T'HH:mm:ss.SSS"),
              logType: LogType.CheckedIn,
            );
            History checkOutHistory = History(
              customer: customer,
              dateTime: refineUTC(
                  customerItem["CheckOutTime"].toString().contains(".")
                      ? customerItem["CheckOutTime"]
                      : "${customerItem["CheckOutTime"]}.000",
                  "yyyy-MM-dd'T'HH:mm:ss.SSS"),
              logType: LogType.CheckedOut,
            );
            items[checkInHistory.dateTime] = checkInHistory;
            items[checkOutHistory.dateTime] = checkOutHistory;
          });
        });
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
    }
  }

  void newCheckIn(Customer customer) {
    items[DateTime.now().toIso8601String()] = History(
        customer: customer,
        dateTime: DateTime.now().toIso8601String(),
        logType: LogType.CheckedIn);
    notifyListeners();
  }

  void newCheckOut(Customer customer) {
    items[DateTime.now().toIso8601String()] = History(
        customer: customer,
        dateTime: DateTime.now().toIso8601String(),
        logType: LogType.CheckedOut);
    notifyListeners();
  }

  void clear() {
    if (items.length > 0) {
      items = {};
      isLoading = true;
      notifyListeners();
    }
  }

  logout() {
    user.isAuthenticated = false;
    userBox.putAt(0, user);
  }
}
