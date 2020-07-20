import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/view/screen/screen_customers.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
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
        title: Text(
          "Routes".toUpperCase(),
          style: getAppBarTextStyle(context),
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(LoginScreen().routeName);
            },
            icon: Icon(FontAwesomeIcons.signOutAlt, size: 20, color: textColor,),
          )
        ],
      ),
      body: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        separatorBuilder: (context, index) => Divider(color: hintColor,thickness: .25,),
        itemBuilder: (context, index) => ListTile(
          dense: true,
          onTap: (){
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
