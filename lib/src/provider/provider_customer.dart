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
  BuildContext context;

  init() {
    userBox = Hive.box("users");
    user = userBox.getAt(0);
  }

  Future<void> getCustomers(String routeId) async {
    try {
      if (customers.values
              .where((element) => element.routeId == routeId)
              .toList()
              .length ==
          0) {
        isLoading = true;
        notifyListeners();
        Map<String, String> headers = {
          "Authorization": user.token,
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
          showNetworkResponse(
              context: context, message: "Customer loaded successfully!");
          Navigator.pop(context);
        } else {
          showNetworkError(context: context);
          isLoading = false;
          notifyListeners();
        }
      }
    } catch (error) {
      showNetworkError(context: context);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCustomers(String routeId) async {
    isLoading = true;
    notifyListeners();
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
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
        showNetworkError(context: context);
        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      showNetworkError(context: context);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> sendNote(BuildContext context, String routeId, String customerId,
      String note) async {
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

      Response response = await NetworkHelper.apiPOST(
          api: apiSendNote, headers: headers, body: body);

      if (response.statusCode == 200) {
        bool result = json.decode(response.body)['result'];
        isLoading = false;
        notifyListeners();
        return result;
      } else {
        isLoading = false;
        showNetworkError(context: context);
        notifyListeners();
        return false;
      }
    } catch (error) {
      isLoading = false;
      showNetworkError(context: context);
      notifyListeners();
      return false;
    }
  }

  Future<bool> checkIn(String customerId, String geeseCount) async {
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "CustomerId": customerId,
        "UserId": user.guid,
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

  Future<bool> checkOut(String customerId) async {
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "CustomerId": customerId,
        "UserId": user.guid,
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

  Future<void> saveImage(
    BuildContext context,
    String path,
    String customerId,
    CustomerProvider customerProvider,
  ) async {
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "CustomerId": customerId,
        "Path": path,
      };

      Response response =
          await NetworkHelper.apiPOST(api: apiSaveMedia, headers: headers);

      if (response.statusCode == 200) {
        customerProvider.newMedia(customerId, apiBaseUrl + path);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showNetworkResponse(context: context, message: "Upload successful!");
      } else {
        Navigator.of(context).pop();
        showNetworkResponseFailed(context: context, message: "Upload failed");
      }
    } catch (error) {
      Navigator.of(context).pop();
      showNetworkResponseFailed(context: context, message: "Upload failed");
    }
  }

  Future<bool> uploadImage(
    BuildContext context,
    File image,
    String customerId,
    CustomerProvider customerProvider,
  ) async {
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "Content-Type": "application/x-www-form-urlencoded",
      };
      Map<String, String> body = {
        "filename": "${DateTime.now().millisecondsSinceEpoch}.png",
        "filepath": base64.encode(image.readAsBytesSync()),
      };

      Response response = await NetworkHelper.apiPOST(
          api: apiUpload, headers: headers, body: body);

      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        Navigator.of(context).pop();
        showDialog(
            context: context, builder: (context) => Loading(Colors.green));
        saveImage(context, result["filePath"], customerId, customerProvider);
      } else {
        Navigator.of(context).pop();
        showNetworkResponse(context: context, message: "Upload failed");
      }
    } catch (error) {
      Navigator.of(context).pop();
      showNetworkResponse(context: context, message: "Something went wrong!");
    }
  }

  List<Customer> customerList(String routeId) {
    List<Customer> list = customers.values
        .where((element) => element.routeId == routeId)
        .toList();
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
}
