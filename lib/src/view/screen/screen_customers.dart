import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geese_releif/src/view/screen/screen_customer_details.dart';
import 'package:geese_releif/src/view/screen/screen_login.dart';
import 'package:geese_releif/src/view/util/constraints.dart';
import 'package:geese_releif/src/view/util/helper.dart';
import 'package:geese_releif/src/view/widget/widget_search.dart';

class CustomersScreen extends StatelessWidget {
  final String routeName = "/customers";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: backgroundColor,
        title: Text(
          "Customers".toUpperCase(),
          style: getAppBarTextStyle(context),
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.search, size: 20, color: textColor,),
            onPressed: () {
              showSearch(context: context, delegate: SearchWidget());
            },
          ),
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
                  SizedBox(height: 2,),
                  Text(
                    "Lead name",
                    style: getCaptionTextStyle(context),
                  ),
                  SizedBox(height: 6,),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "City, ST *****",
                    style: getDefaultTextStyle(context),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    "Phone",
                    style: getCaptionTextStyle(context),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Text(
            "Date",
            style: getCaptionTextStyle(context),
          ),
        ),
        itemCount: 5,
      ),
    );
  }
}
