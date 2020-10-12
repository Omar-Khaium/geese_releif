import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/provider/provider_keyboard.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/view/widget/widget_loading.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UploadFileScreen extends StatelessWidget {
  final String routeName = "/upload_file";

  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final keyboardProvider = Provider.of<KeyboardProvider>(context, listen: true);
    Map<String, dynamic> data = Map<String, dynamic>.from(ModalRoute.of(context).settings.arguments);
    File image = data["image"] as File;
    String customerId = data["customerId"] as String;
    final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
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
                ? PhotoView.customChild(
              minScale: 1.0,
              tightMode: true,
              child: Image.memory(
                image.readAsBytesSync(),
                fit: BoxFit.contain,
                scale: 1,
                filterQuality: FilterQuality.high,
              ),
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
                  if (keyboardProvider.isKeyboardVisible) {
                    keyboardProvider.hideKeyboard(context);
                  }
                  showDialog(context: context, builder: (context) => Loading(Colors.blue));
                  customerProvider.uploadImage(context, image, noteController.text, customerId, customerProvider);
                },
                child: Text(
                  "Upload",
                  style: getButtonTextStyle(context, isOutline: false),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 84,
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: TextField(
                controller: noteController,
                keyboardType: TextInputType.multiline,
                cursorColor: textColor,
                textAlign: TextAlign.justify,
                textAlignVertical: TextAlignVertical.top,
                maxLines: 4,
                style: getDefaultTextStyle(context),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: accentColor, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: accentColor, width: 2),
                  ),
                  hintText: "Write a note...",
                  hintStyle: getHintTextStyle(context),
                  isDense: true,
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
          Positioned(
            right: 16,
            top: MediaQuery.of(context).padding.top + 4,
            child: Visibility(
              visible: keyboardProvider.isKeyboardVisible,
              child: IconButton(
                onPressed: () {
                  keyboardProvider.hideKeyboard(context);
                },
                icon: Icon(
                  Icons.keyboard_hide,
                  color: accentColor,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
