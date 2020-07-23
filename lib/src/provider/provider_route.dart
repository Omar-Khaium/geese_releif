import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geesereleif/src/view/screen/screen_customers.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:http/http.dart';
import 'package:geesereleif/src/model/route.dart';
import 'package:geesereleif/src/view/util/network_helper.dart';

class RouteProvider extends ChangeNotifier {
  Map<String, Routes> routes = {};
  bool isLoading = true;

  Future<void> getRoutes(String token) async {
    try {
      Map<String, String> headers = {
        "Authorization": token,
      };

      Response response =
          await NetworkHelper.apiGET(api: apiRoutes, headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(
            json.decode(response.body)["orglist"]);
        for (Map<String, dynamic> map in result) {
          Routes route = Routes.fromJson(map);
          if (!routes.containsKey(route.guid)) routes[route.guid] = route;
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

  Future<void> selectRoutes(
      BuildContext context, String token, String id) async {
    try {
      Map<String, String> headers = {'Authorization': token, 'Companyid': id};

      Map<String, String> body = {};

      Response response = await NetworkHelper.apiPOST(
          api: apiSelectRoutes, headers: headers, body: body);

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(CustomersScreen().routeName);
      } else {
        isLoading = false;
        Navigator.of(context).pop();
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
    }
  }

  List<Routes> get routeList {
    return routes.values.toList();
  }

  clear() {
    routes = {};
    isLoading = true;
    notifyListeners();
  }
}
