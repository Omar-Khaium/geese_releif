import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/view/screen/screen_customer_details.dart';
import 'package:geesereleif/src/view/screen/screen_history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/view/screen/screen_profile.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/helper.dart';
import 'package:geesereleif/src/view/widget/widget_search.dart';
import 'package:maps_launcher/maps_launcher.dart';

class CustomersScreen extends StatelessWidget {
  final String routeName = "/customers";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: backgroundColor,
        title: Text(
          "Customers".toUpperCase(),
          style: getAppBarTextStyle(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.search,
              size: 20,
              color: textColor,
            ),
            onPressed: () {
              showSearch(context: context, delegate: SearchWidget());
            },
          ),
          ClipRRect(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            borderRadius: BorderRadius.circular(32),
            child: IconButton(
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  "https://uifaces.co/our-content/donated/8CEV1nXA.jpg",
                ),
              ),
              onPressed: () {
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
            Navigator.of(context).pushNamed(CustomerDetailsScreen().routeName);
          },
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 18,
            color: hintColor,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Customer name",
                    style: getDefaultTextStyle(context, isFocused: true),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Lead name",
                    style: getCaptionTextStyle(context),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                ],
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  MapsLauncher.launchQuery("Street\nCity, ST *****");
                },
                child: Text(
                  "Street\nCity, ST *****",
                  style: getClickableTextStyle(context),
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "dd MMM, yyyy h:mm a",
                style: getCaptionTextStyle(context),
              ),
              Text(
                "(xxx) xxx xxxx",
                style: getCaptionTextStyle(context),
              ),
            ],
          ),
        ),
        itemCount: 5,
      ),
    );
  }
}
