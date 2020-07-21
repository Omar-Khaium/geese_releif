import 'package:flutter/material.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/helper.dart';

class HistoryScreen extends StatelessWidget {
  final String routeName = "/history";
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
            child: Text("History", style: getAppBarTextStyle(context),),
          ),
        ],
      ),
    );
  }
}
