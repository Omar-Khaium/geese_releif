import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geese_releif/src/view/screen/screen_login.dart';
import 'package:geese_releif/src/view/util/constraints.dart';
import 'package:geese_releif/src/view/util/helper.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final String routeName = "/customer_details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: backgroundColor,
        title: Text(
          "Customers Name".toUpperCase(),
          style: getAppBarTextStyle(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(LoginScreen().routeName);
            },
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              size: 20,
              color: textColor,
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * .1 - 12),
        child: FloatingActionButton(
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              builder: (context) => CupertinoActionSheet(
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    child: Text(
                      "Camera",
                      style: getClickableTextStyle(context),
                    ),
                    onPressed: () {},
                  ),
                  CupertinoActionSheetAction(
                    child:
                        Text("Photos", style: getClickableTextStyle(context)),
                    onPressed: () {},
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: Text(
                    "Close",
                    style: getDeleteTextStyle(context),
                  ),
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
          backgroundColor: accentColor,
          child: Icon(
            FontAwesomeIcons.plus,
            size: 20,
            color: Colors.white,
          ),
          mini: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              children: [],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: accentColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0,1),
                  color: Colors.grey.shade100,
                  spreadRadius: 8,
                  blurRadius: 8
                )
              ]),
              child: InkWell(
                onTap: () {},
                splashColor: Colors.black,
                highlightColor: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child: Text(
                    "Check In",
                    style: getButtonTextStyle(context, isOutline: false),
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
