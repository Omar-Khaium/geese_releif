/*..............................................................
 . Created by Tanvir Ahmed on 6/3/20 3:27 PM                   .
 .  Copyright (c) 2020 . All rights reserved.                  .
 .  Last modified 6/3/20 3:21 PM                               .
 ..............................................................*/

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'constraints.dart';

class NetworkHelper {
  static Future<Response> apiGET(
      {@required String api, Map<String, String> headers}) async {
    return await get(apiBaseUrl + api, headers: headers);
  }

  static Future<Response> apiPOST(
      {@required String api,
        Map<String, String> headers,
        Map<String, String> body}) async {
    return await post(apiBaseUrl + api, headers: headers, body: body);
  }

  static Future<Response> apiDELETE(
      {@required String api, Map<String, String> headers}) async {
    return await delete(apiBaseUrl + api, headers: headers);
  }
}
