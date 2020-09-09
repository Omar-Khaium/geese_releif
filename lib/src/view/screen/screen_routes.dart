import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/provider/provider_route.dart';
import 'package:geesereleif/src/view/screen/screen_customers.dart';
import 'package:geesereleif/src/view/screen/screen_history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/util/constraints.dart';
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
          ActionChip(
            onPressed: () {
              Navigator.of(context).pushNamed(HistoryScreen().routeName);
            },
            label: Text(
              user.name.length > 11 ? "History" : user.name,
              style: getDefaultTextStyle(context),
            ),
            labelPadding: const EdgeInsets.only(right: 4),
            avatar: Icon(
              FontAwesomeIcons.history,
              size: 14,
              color: Colors.grey.shade700,
            ),
            backgroundColor: Colors.grey.shade200,
            elevation: 0,
          ),
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(LoginScreen().routeName),
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.black,
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
              : RefreshIndicator(
                  onRefresh: () {
                    return routeProvider.refreshRoutes(user.token);
                  },
                  child: ListView.separated(
                    shrinkWrap: false,
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(
                      color: hintColor,
                      thickness: .25,
                    ),
                    itemBuilder: (context, index) => ListTile(
                      dense: true,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            CustomersScreen().routeName,
                            arguments: routeProvider.routeList[index].guid);
                      },
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 18,
                        color: hintColor,
                      ),
                      title: Text(
                        routeProvider.routeList[index].name ?? "-",
                        style: getDefaultTextStyle(context, isFocused: true),
                      ),
                    ),
                    itemCount: routeProvider.routeList.length,
                  ),
                ),
    );
  }
}
