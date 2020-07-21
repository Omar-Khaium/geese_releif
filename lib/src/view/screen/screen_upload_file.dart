import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/helper.dart';

class UploadFileScreen extends StatelessWidget {
  final String routeName = "/upload_file";
  @override
  Widget build(BuildContext context) {
    File image = ModalRoute.of(context).settings.arguments as File;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 64,
            child: Image.memory(
              image.readAsBytesSync(),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: 64,
              child: FlatButton(
                color: accentColor,
                onPressed: () {},
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
                  onPressed: ()=>Navigator.of(context).pop(),
                  icon: Icon(FontAwesomeIcons.times, color: Colors.white, size: 24,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
