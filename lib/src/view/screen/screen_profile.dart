import 'package:flutter/material.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/helper.dart';

class ProfileScreen extends StatelessWidget {
  final String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,),
        children: [
          Center(
            child: Text("Profile", style: getAppBarTextStyle(context),),
          )
        ],
      ),
    );
  }
}
