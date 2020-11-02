import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/model/history.dart';
import 'package:geesereleif/src/model/user.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';
import 'package:geesereleif/src/util/network_helper.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

class HistoryProvider extends ChangeNotifier {
  Map<String, History> items = HashMap<String, History>();

  // Map<String, bool> hasData = HashMap<String, bool>();
  bool isLoading = false;
  bool isFirstTime = true;
  User user;
  Box<User> userBox;

  init() {
    userBox = Hive.box("users");
    if(userBox.length > 0) {
      user = userBox.getAt(0);
    }
  }

  List<History> getAllHistories(String customerId) {
    List<History> _list = items.values
        .where((element) => element.customerGUID == customerId && element.dateTime != null && element.dateTime.startsWith("20"))
        .toList();

    _list.sort(
        (a, b) => stringToDateTime(b.dateTime).microsecondsSinceEpoch.compareTo(stringToDateTime(a.dateTime).microsecondsSinceEpoch));
    _list = parseHistory(_list);
    if (_list.length > 0) {
      if (_list[0].logType == LogType.CheckedIn) {
        _list[0].logType = LogType.Active;
      }
    }
    return _list;
  }

  History findHistoryByID(String time) => items.containsKey(time) ? items[time] : null;

  Future<int> getHistory(String customerID) async {
    items.removeWhere((key, value) => value.customerGUID == customerID);
    isFirstTime = false;
    if (!isLoading) {
      isLoading = true;
    }

    notifyListeners();
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "CustomerId": customerID,
      };

      Response response = await NetworkHelper.apiGET(api: apiHistory, headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(json.decode(response.body)["GeeseCustomerList"].toList());
        result.forEach((map) {
          if (map["IsCheckedIn"] ?? false) {
            History checkedInHistory = History(
              dateTime: refineUTC(
                  map["CheckInTime"].toString().contains(".") ? map["CheckInTime"].toString() : "${map["CheckInTime"].toString()}.000",
                  ultimateDateFormat),
              customerGUID: map["CustomerId"],
              checkedBy: map["UserName"],
              geeseCount: map["GeeseCount"],
              logType: LogType.Active,
            );
            items[checkedInHistory.dateTime] = checkedInHistory;
          } else {
            History checkedInHistory = History(
              dateTime: refineUTC(
                  map["CheckInTime"].toString().contains(".") ? map["CheckInTime"].toString() : "${map["CheckInTime"].toString()}.000",
                  ultimateDateFormat),
              customerGUID: map["CustomerId"],
              checkedBy: map["UserName"],
              geeseCount: map["GeeseCount"],
              logType: LogType.CheckedIn,
            );
            History checkedOutHistory = History(
              dateTime: refineUTC(
                  map["CheckOutTime"].toString().contains(".")
                      ? map["CheckOutTime"].toString()
                      : "${map["CheckOutTime"].toString()}.000",
                  ultimateDateFormat),
              customerGUID: map["CustomerId"],
              checkedBy: map["UserName"],
              geeseCount: map["GeeseCount"],
              logType: LogType.CheckedOut,
            );
            items[checkedInHistory.dateTime] = checkedInHistory;
            items[checkedOutHistory.dateTime] = checkedOutHistory;
          }
        });
        isLoading = false;
        // hasData[customerID] = false;
        notifyListeners();
        return 200;
      } else {
        isLoading = false;
        // hasData[customerID] = false;
        notifyListeners();
        return 400;
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      if (error.toString().contains("SocketException")) {
        return 503;
      } else {
        return 500;
      }
    }
  }

  Future<void> refreshHistory(String customerID) async {
    items.removeWhere((key, value) => value.customerGUID == customerID);
    isFirstTime = false;
    if (!isLoading) {
      isLoading = true;
    }

    notifyListeners();
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "CustomerId": customerID,
      };

      Response response = await NetworkHelper.apiGET(api: apiHistory, headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(json.decode(response.body)["GeeseCustomerList"].toList());
        result.forEach((map) {
          if (map["IsCheckedIn"] ?? false) {
            History checkedInHistory = History(
              dateTime: refineUTC(
                  map["CheckInTime"].toString().contains(".") ? map["CheckInTime"].toString() : "${map["CheckInTime"].toString()}.000",
                  ultimateDateFormat),
              customerGUID: map["CustomerId"],
              checkedBy: map["UserName"],
              geeseCount: map["GeeseCount"],
              logType: LogType.Active,
            );
            items[checkedInHistory.dateTime] = checkedInHistory;
          } else {
            History checkedInHistory = History(
              dateTime: refineUTC(
                  map["CheckInTime"].toString().contains(".") ? map["CheckInTime"].toString() : "${map["CheckInTime"].toString()}.000",
                  ultimateDateFormat),
              customerGUID: map["CustomerId"],
              checkedBy: map["UserName"],
              geeseCount: map["GeeseCount"],
              logType: LogType.CheckedIn,
            );
            History checkedOutHistory = History(
              dateTime: refineUTC(
                  map["CheckOutTime"].toString().contains(".")
                      ? map["CheckOutTime"].toString()
                      : "${map["CheckOutTime"].toString()}.000",
                  ultimateDateFormat),
              customerGUID: map["CustomerId"],
              checkedBy: map["UserName"],
              geeseCount: map["GeeseCount"],
              logType: LogType.CheckedOut,
            );
            items[checkedInHistory.dateTime] = checkedInHistory;
            items[checkedOutHistory.dateTime] = checkedOutHistory;
          }
        });
        isLoading = false;
        // hasData[customerID] = false;
        notifyListeners();
      } else {
        isLoading = false;
        // hasData[customerID] = false;
        notifyListeners();
      }
    } catch (error) {
      isLoading = false;
      // hasData[customerID] = false;
      notifyListeners();
    }
  }

  void newCheckIn(Customer customer, int geeseCount) {
    items[refineLocal(DateTime.now().toIso8601String())] = History(
        customerGUID: customer.guid,
        dateTime: refineLocal(DateTime.now().toIso8601String()),
        logType: LogType.Active,
        geeseCount: geeseCount,
        checkedBy: user.name);
    notifyListeners();
  }

  void newCheckOut(Customer customer) {
    items.values.forEach((element) {
      if (element.logType == LogType.Active) {
        element.logType = LogType.CheckedIn;
      }
    });
    items[refineLocal(DateTime.now().toIso8601String())] = History(
      customerGUID: customer.guid,
      dateTime: refineLocal(DateTime.now().toIso8601String()),
      logType: LogType.CheckedOut,
      geeseCount: 0,
      checkedBy: user.name,
    );
    notifyListeners();
  }

  void clear() {
    if (items.length > 0) {
      items = {};
      isLoading = false;
      isFirstTime = true;
      notifyListeners();
    }
    /*if (hasData.length > 0) {
      hasData = {};
      notifyListeners();
    }*/
  }

  reset() {
    isFirstTime = true;
    notifyListeners();
  }

  resetNetwork() {
    isLoading = false;
    notifyListeners();
  }

  logout() {
    user.isAuthenticated = false;
    userBox.putAt(0, user);
    clear();
  }
}
