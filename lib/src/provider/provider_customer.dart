import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geesereleif/src/model/note.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/model/media_file.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/network_helper.dart';
import 'package:http/http.dart';

class CustomerProvider extends ChangeNotifier {
  Map<String, Customer> customers = {};
  bool isLoading = true;

  Future<void> getCustomers(String token, String routeId) async {
    try {
      Map<String, String> headers = {
        "Authorization": token,
        "PageNo": "1",
        "PageSize": "10",
        "RouteId": routeId,
      };

      Response response =
          await NetworkHelper.apiGET(api: apiCustomers, headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(
            json.decode(response.body)['CustomerDetail']);
        for (Map<String, dynamic> map in result) {
          Customer customer = Customer.fromJson(
              map["Customers"],
              List<Map<String, dynamic>>.from(map["Media"]),
              List<Map<String, dynamic>>.from(map["Note"]),
              routeId);
          if (!customers.containsKey(customer.guid))
            customers[customer.guid] = customer;
        }
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

  Future<void> refreshCustomers(String token, String routeId) async {
    isLoading = true;
    notifyListeners();
    try {
      Map<String, String> headers = {
        "Authorization": token,
        "PageNo": "1",
        "PageSize": "10",
        "RouteId": routeId,
      };

      Response response =
          await NetworkHelper.apiGET(api: apiCustomers, headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(
            json.decode(response.body)['CustomerDetail']);
        for (Map<String, dynamic> map in result) {
          Customer customer = Customer.fromJson(
              map["Customers"],
              List<Map<String, dynamic>>.from(map["Media"]),
              List<Map<String, dynamic>>.from(map["Note"]),
              routeId);
          if (!customers.containsKey(customer.guid))
            customers[customer.guid] = customer;
        }
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

  Future<bool> sendNote(String token, String routeId, String userId,
      String customerId, String note) async {
    isLoading = true;
    notifyListeners();
    try {
      Map<String, String> headers = {
        "Authorization": token,
        "CustomerId": customerId,
        "UserId": userId,
        "Note": note,
      };

      Map<String, String> body = {};

      Response response = await NetworkHelper.apiPOST(
          api: apiSendNote, headers: headers, body: body);

      if (response.statusCode == 200) {
        bool result = json.decode(response.body)['result'];
        isLoading = false;
        notifyListeners();
        return result;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> checkIn(
      String token, String userId, String customerId, String geeseCount) async {
    try {
      Map<String, String> headers = {
        "Authorization": token,
        "CustomerId": customerId,
        "UserId": userId,
        "GeeseCount": geeseCount,
      };

      Map<String, String> body = {};

      Response response = await NetworkHelper.apiPOST(
          api: apiCheckIn, headers: headers, body: body);

      if (response.statusCode == 200) {
        return json.decode(response.body)['result'] as bool;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> checkOut(String token, String userId, String customerId) async {
    try {
      Map<String, String> headers = {
        "Authorization": token,
        "CustomerId": customerId,
        "UserId": userId,
      };

      Map<String, String> body = {};

      Response response = await NetworkHelper.apiPOST(
          api: apiCheckOut, headers: headers, body: body);

      if (response.statusCode == 200) {
        return json.decode(response.body)['result'] as bool;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  List<Customer> customerList(String routeId) {
    return customers.values
        .where((element) => element.routeId == routeId)
        .toList();
  }

  clear() {
    if (customers.length > 0) {
      customers = {};
      isLoading = true;
      notifyListeners();
    }
  }

  Customer findCustomerByID(String id) {
    return customers.values.firstWhere((element) => element.guid == id);
  }

  void newMedia(String customerId, String path) {
    Customer customer = findCustomerByID(customerId);
    customer.mediaList.add(
          MediaFile(path, DateTime.now().toIso8601String()),);
    notifyListeners();
  }

  void newNote(String customerId, Note note) {
    Customer customer = findCustomerByID(customerId);
    customer.noteList.add(note);
    notifyListeners();
  }

  void newCheckIn(String customerId, int geeseCount ) {
    Customer customer = findCustomerByID(customerId);
    customer.isCheckedIn = true;
    customer.geeseCount = geeseCount;
    notifyListeners();
  }

  void newCheckOut(String customerId) {
    Customer customer = findCustomerByID(customerId);
    customer.isCheckedIn = false;
    notifyListeners();
  }
}
