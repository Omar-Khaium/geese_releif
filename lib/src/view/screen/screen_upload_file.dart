import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/view/widget/widget_loading.dart';
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
                  showDialog(context: context, builder: (context) => Loading(Colors.blue));
                  customerProvider.uploadImage(context, image, customerId, customerProvider);
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
}
