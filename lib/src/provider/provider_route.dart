import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geesereleif/src/model/route.dart';
import 'package:geesereleif/src/model/user.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';
import 'package:geesereleif/src/util/network_helper.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

class RouteProvider extends ChangeNotifier {
  Map<String, Routes> routes = {};
  bool isLoading = true;
  User user;
  Box<User> userBox;

  init() {
    userBox = Hive.box("users");
    user = userBox.getAt(0);
  }

  Future<void> getRoutes(BuildContext context) async {
    try {
      routes = {};
      Map<String, String> headers = {
        "Authorization": user.token,
        "UserId": user.guid,
        "PageNo": "1",
        "PageSize": "10",
      };

      Response response =
          await NetworkHelper.apiGET(api: apiRoutes, headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(
            json.decode(response.body)["RouteList"].toList());
        for (Map<String, dynamic> map in result) {
          Routes route = Routes.fromJson(map);
          if (!routes.containsKey(route.guid)) routes[route.guid] = route;
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        alertERROR(context: context, message: "Something went wrong.");
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      if(error.toString().contains("SocketException")){
        networkERROR(context: context);
      } else {
        alertERROR(context: context, message: "Something went wrong.");
      }
    }
  }

  Future<void> refreshRoutes(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      Map<String, String> headers = {
        "Authorization": user.token,
        "UserId": user.guid,
        "PageNo": "1",
        "PageSize": "100",
      };

      Response response =
          await NetworkHelper.apiGET(api: apiRoutes, headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(
            json.decode(response.body)["RouteList"].toList());
        for (Map<String, dynamic> map in result) {
          Routes route = Routes.fromJson(map);
          if (!routes.containsKey(route.guid)) routes[route.guid] = route;
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        alertERROR(context: context, message: "Something went wrong.");
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      if(error.toString().contains("SocketException")){
        networkERROR(context: context);
      } else {
        alertERROR(context: context, message: "Something went wrong.");
      }
    }
  }

  List<Routes> get routeList {
    return routes == null ? 0 : routes.values.toList();
  }

  clear() {
    routes = {};
    isLoading = true;
    notifyListeners();
  }

  logout() {
    user.isAuthenticated = false;
    userBox.putAt(0, user);
  }
}
