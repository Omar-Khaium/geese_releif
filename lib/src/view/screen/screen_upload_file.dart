import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/model/media_file.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/network_helper.dart';
import 'package:geesereleif/src/view/widget/widget_loading.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class UploadFileScreen extends StatelessWidget {
  final String routeName = "/upload_file";
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        Map<String, dynamic>.from(ModalRoute.of(context).settings.arguments);
    File image = data["image"] as File;
    String customerId = data["customerId"] as String;
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    if (image == null) {
      Navigator.of(context).pop();
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 64,
            child: image != null
                ? Image.memory(
                    image.readAsBytesSync(),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  )
                : Container(),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: 64,
              child: FlatButton(
                color: accentColor,
                onPressed: () {
                  showDialog(context: context, builder: (context) => Loading());
                  uploadImage(context, image, customerId, customerProvider);
                },
                child: Text(
                  "Upload",
                  style: getButtonTextStyle(context, isOutline: false),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: MediaQuery.of(context).padding.top + 4,
            child: Container(
              height: 64,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.black26,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    FontAwesomeIcons.times,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
        customerProvider.newMedia(customerId, apiBaseUrl+path);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pop();
      }
    } catch (error) {
      Navigator.of(context).pop();
    }
  }

  Future<void> uploadImage(
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
        saveImage(context, result["filePath"], customerId, customerProvider);
      } else {
        Navigator.of(context).pop();
      }
    } catch (error) {
      Navigator.of(context).pop();
    }
  }
}
