import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/model/media_file.dart';
import 'package:geesereleif/src/model/note.dart';
import 'package:geesereleif/src/model/user.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';
import 'package:geesereleif/src/util/network_helper.dart';
import 'package:geesereleif/src/view/widget/widget_loading.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

class CustomerProvider extends ChangeNotifier {
  Map<String, Customer> customers = {};
  bool isLoading = true;
  User user;
  Box<User> userBox;

  init() {
    userBox = Hive.box("users");
    user = userBox.getAt(0);
  }

  Future<void> getCustomers(String routeId, BuildContext context) async {
    try {
      if (customers.values
          .where((element) => element.routeId == routeId)
          .toList()
          .length == 0) {
        isLoading = true;
        notifyListeners();
        Map<String, String> headers = {
          "Authorization": user.token,
          "PageNo": "1",
          "PageSize": "100",
          "RouteId": routeId,
        };

        Response response = await NetworkHelper.apiGET(api: apiCustomers, headers: headers);

        if (response.statusCode == 200) {
          List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(json.decode(response.body)['CustomerDetail']);
          for (Map<String, dynamic> map in result) {
            Customer customer = Customer.fromJson(
                map["Customers"], List<Map<String, dynamic>>.from(map["Media"]), List<Map<String, dynamic>>.from(map["Note"]), routeId);
            if (!customers.containsKey(customer.guid)) customers[customer.guid] = customer;
          }
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
          alertERROR(context: context, message: "Something went wrong.");
        }
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      if (error.toString().contains("SocketException")) {
        networkERROR(context: context);
      } else {
        alertERROR(context: context, message: "Something went wrong.");
      }
    }
  }

  Future<void> refreshCustomers(String routeId, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "PageNo": "1",
        "PageSize": "100",
        "RouteId": routeId,
      };

      Response response = await NetworkHelper.apiGET(api: apiCustomers, headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(json.decode(response.body)['CustomerDetail']);
        for (Map<String, dynamic> map in result) {
          Customer customer = Customer.fromJson(
              map["Customers"], List<Map<String, dynamic>>.from(map["Media"]), List<Map<String, dynamic>>.from(map["Note"]), routeId);
          if (!customers.containsKey(customer.guid)) customers[customer.guid] = customer;
        }
        isLoading = false;
        notifyListeners();
      } else {
        alertERROR(context: context, message: "Something went wrong.");
        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      if (error.toString().contains("SocketException")) {
        networkERROR(context: context);
      } else {
        alertERROR(context: context, message: "Something went wrong.");
      }
    }
  }

  Future<bool> sendNote(BuildContext context, String routeId, String customerId, String note) async {
    isLoading = true;
    notifyListeners();
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "CustomerId": customerId,
        "UserId": user.guid,
        "Note": note,
      };

      Map<String, String> body = {};

      Response response = await NetworkHelper.apiPOST(api: apiSendNote, headers: headers, body: body);

      if (response.statusCode == 200) {
        isLoading = false;
        notifyListeners();
        Navigator.of(context).pop();
        alertSuccess(context: context, message: "Note published successfully.");
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        Navigator.of(context).pop();
        alertERROR(context: context, message: "Something went wrong.");
        return false;
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      Navigator.of(context).pop();
      if (error.toString().contains("SocketException")) {
        networkERROR(context: context);
      } else {
        alertERROR(context: context, message: "Something went wrong.");
      }
      return false;
    }
  }

  Future<bool> checkIn(BuildContext context, String customerId, String geeseCount) async {
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "CustomerId": customerId,
        "UserId": user.guid,
        "GeeseCount": geeseCount,
      };

      Map<String, String> body = {};

      Response response = await NetworkHelper.apiPOST(api: apiCheckIn, headers: headers, body: body);

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        alertSuccess(context: context, message: "Checked in successfully.");
        return json.decode(response.body)['result'] as bool;
      } else {
        Navigator.of(context).pop();
        alertERROR(context: context, message: json.decode(response.body)["message"].toString());
        return false;
      }
    } catch (error) {
      Navigator.of(context).pop();
      if (error.toString().contains("SocketException")) {
        networkERROR(context: context);
      } else {
        alertERROR(context: context, message: "Something went wrong.");
      }
      return false;
    }
  }

  Future<bool> checkOut(BuildContext context, String customerId) async {
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "CustomerId": customerId,
        "UserId": user.guid,
      };

      Map<String, String> body = {};

      Response response = await NetworkHelper.apiPOST(api: apiCheckOut, headers: headers, body: body);

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        alertSuccess(context: context, message: "Checked out successfully.");
        return json.decode(response.body)['result'] as bool;
      } else {
        Navigator.of(context).pop();
        alertERROR(context: context, message: json.decode(response.body)["message"].toString());
        return false;
      }
    } catch (error) {
      Navigator.of(context).pop();
      if (error.toString().contains("SocketException")) {
        networkERROR(context: context);
      } else {
        alertERROR(context: context, message: "Something went wrong.");
      }
      return false;
    }
  }

  Future<void> saveImage(BuildContext context,
      String path,
      String customerId,
      CustomerProvider customerProvider,) async {
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "CustomerId": customerId,
        "Path": path,
      };

      Response response = await NetworkHelper.apiPOST(api: apiSaveMedia, headers: headers);

      if (response.statusCode == 200) {
        customerProvider.newMedia(customerId, apiBaseUrl + path);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        alertSuccess(context: context, message: "Photo uploaded successfully.");
      } else {
        Navigator.of(context).pop();
        alertERROR(context: context, message: "Failed to save photo.");
      }
    } catch (error) {
      Navigator.of(context).pop();
      if (error.toString().contains("SocketException")) {
        networkERROR(context: context);
      } else {
        alertERROR(context: context, message: "Something went wrong.");
      }
    }
  }

  Future<bool> uploadImage(BuildContext context,
      File image,
      String customerId,
      CustomerProvider customerProvider,) async {
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "Content-Type": "application/x-www-form-urlencoded",
      };
      Map<String, String> body = {
        "filename": "${DateTime
            .now()
            .millisecondsSinceEpoch}.png",
        "filepath": base64.encode(image.readAsBytesSync()),
      };

      Response response = await NetworkHelper.apiPOST(api: apiUpload, headers: headers, body: body);

      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        Navigator.of(context).pop();
        showDialog(context: context, builder: (context) => Loading(Colors.green));
        saveImage(context, result["filePath"], customerId, customerProvider);
        return true;
      } else {
        Navigator.of(context).pop();
        alertERROR(context: context, message: "Failed to upload photo.");
        return false;
      }
    } catch (error) {
      Navigator.of(context).pop();
      if (error.toString().contains("SocketException")) {
        networkERROR(context: context);
      } else {
        alertERROR(context: context, message: "Something went wrong.");
      }
      return false;
    }
  }

  List<Customer> customerList(String routeId) {
    List<Customer> list = customers.values.where((element) => element.routeId == routeId).toList();
    return list;
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
      MediaFile(path, DateTime.now().toIso8601String()),
    );
    notifyListeners();
  }

  void newNote(String customerId, Note note) {
    Customer customer = findCustomerByID(customerId);
    customer.noteList.add(note);
    notifyListeners();
  }

  void newCheckIn(String customerId, int geeseCount) {
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

  logout() {
    user.isAuthenticated = false;
    userBox.putAt(0, user);
  }

  changeLastCheckInOutTime(String date, String guid) {
    customers[guid].lastCheckIn = date;
    notifyListeners();
  }
}
