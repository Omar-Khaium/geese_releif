import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geesereleif/src/view/screen/screen_customers.dart';
import 'package:geesereleif/src/view/screen/screen_history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/view/screen/screen_profile.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/helper.dart';

class RoutesScreen extends StatelessWidget {
  final String routeName = "/routes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        titleSpacing: 16,
        centerTitle: false,
        title: Text(
          "Routes".toUpperCase(),
          style: getAppBarTextStyle(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(
                "John Doe",
                style: getDefaultTextStyle(context),
              ),
              onSelected: (flag) {
                showCupertinoModalPopup(
                  context: context,
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  builder: (context) => CupertinoActionSheet(
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        child: Text(
                          "Profile",
                          style: getClickableTextStyle(context, forMenu: true),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed(ProfileScreen().routeName);
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: Text("History",
                            style:
                                getClickableTextStyle(context, forMenu: true)),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed(HistoryScreen().routeName);
                        },
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      child: Text(
                        "Logout",
                        style: getDeleteTextStyle(context),
                      ),
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen().routeName);
                      },
                    ),
                  ),
                );
              },
              clipBehavior: Clip.antiAliasWithSaveLayer,
              avatar: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  "https://uifaces.co/our-content/donated/8CEV1nXA.jpg",
                ),
              ),
              selected: false,
              backgroundColor: Colors.grey.shade200,
              elevation: 0,
            ),
          ),
        ],
      ),
      body: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        separatorBuilder: (context, index) => Divider(
          color: hintColor,
          thickness: .25,
        ),
        itemBuilder: (context, index) => ListTile(
          dense: true,
          onTap: () {
            Navigator.of(context).pushNamed(CustomersScreen().routeName);
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 18,
            color: hintColor,
          ),
          title: Text(
            "Route name",
            style: getDefaultTextStyle(context, isFocused: true),
          ),
          subtitle: Text(
            "Caption",
            style: getCaptionTextStyle(context),
          ),
        ),
        itemCount: 5,
      ),
    );
  }
}
