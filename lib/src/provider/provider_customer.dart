import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/network_helper.dart';
import 'package:http/http.dart';

class CustomerProvider extends ChangeNotifier {
  Map<String, Customer> customers = {};
  bool isLoading = true;

  Future<void> getCustomers(String token) async {
    try {
      Map<String, String> headers = {
        "Authorization": token,
        "PageNo": "1",
        "PageSize": "100",
        "ResultType": "Customer"
      };

      Response response =
          await NetworkHelper.apiGET(api: apiCustomers, headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(
            json.decode(response.body)['data']['CustomerList']);
        for (Map<String, dynamic> map in result) {
          Customer customer = Customer.fromJson(map);
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

  List<Customer> get customerList {
    return customers.values.toList();
  }

  clear() {
    if (customers.length > 0) {
      customers = {};
      isLoading = true;
      notifyListeners();
    }
  }

  Customer findCustomerByID(String id) {
    return customers.values.firstWhere((element) => element.guid==id);
  }
}
