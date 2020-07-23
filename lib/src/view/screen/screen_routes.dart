import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geesereleif/src/provider/provider_route.dart';
import 'package:geesereleif/src/view/screen/screen_customers.dart';
import 'package:geesereleif/src/view/screen/screen_history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/view/screen/screen_profile.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/widget/widget_loading.dart';
import 'package:provider/provider.dart';

class RoutesScreen extends StatelessWidget {
  final String routeName = "/routes";

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RouteProvider>(context);
    if (routeProvider.routes.length == 0) routeProvider.getRoutes(user.token);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        titleSpacing: 16,
        automaticallyImplyLeading: false,
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
                user.name.length > 11
                    ? "${user.name.substring(0, 11)}..."
                    : user.name,
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
                child: user.profilePicture.contains("File") ? Image.network(
                  user.profilePicture,
                  fit: BoxFit.cover,
                  width: 32,
                  height: 32,
                  filterQuality: FilterQuality.low,
                ) : Icon(Icons.person, color: textColor,),
              ),
              selected: false,
              backgroundColor: Colors.grey.shade200,
              elevation: 0,
            ),
          ),
        ],
      ),
      body: routeProvider.isLoading
          ? Center(
              child: Container(
                width: 144,
                height: 144,
                child: Image.asset(
                  "images/loading.gif",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            )
          : routeProvider.routeList.length == 0
              ? Center(
                  child: Text(
                    "No routes available",
                    style: getHintTextStyle(context),
                  ),
                )
              : ListView.separated(
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
                      showDialog(context: context, builder: (context)=>Loading());
                      routeProvider.selectRoutes(context, user.token, routeProvider.routeList[index].guid);
                    },
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: 18,
                      color: hintColor,
                    ),
                    title: Text(
                      routeProvider.routeList[index].name,
                      style: getDefaultTextStyle(context, isFocused: true),
                    ),
                  ),
                  itemCount: routeProvider.routeList.length,
                ),
    );
  }
}
