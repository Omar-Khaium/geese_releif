import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/view/screen/screen_history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/view/screen/screen_profile.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/widget/list_item/item_customer.dart';
import 'package:geesereleif/src/view/widget/widget_search.dart';
import 'package:provider/provider.dart';

class CustomersScreen extends StatelessWidget {
  final String routeName = "/customers";

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    if(customerProvider.customerList.length==0) {
      customerProvider.getCustomers(user.token);
    }
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
                child: user.profilePicture.contains("File") ? Image.network(
                  user.profilePicture,
                  fit: BoxFit.cover,
                  width: 32,
                  height: 32,
                  filterQuality: FilterQuality.low,
                ) : Icon(Icons.person,color: textColor,),
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
      body: customerProvider.isLoading ? Center(
        child: Container(
          width: 144,
          height: 144,
          child: Image.asset(
            "images/loading.gif",
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
      ) : customerProvider.customerList.length == 0
          ? Center(
        child: Text(
          "No customer available",
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
        itemBuilder: (context, index) {

          final Customer customer = customerProvider.customerList[index];
          return CustomerItem(customer);
        },
        itemCount: customerProvider.customerList.length,
      ),
    );
  }
}
