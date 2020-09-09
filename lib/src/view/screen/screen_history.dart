import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/provider/provider_history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/view/widget/list_item/item_history.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HistoryScreen extends StatelessWidget {
  final String routeName = "/history";

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: true);
    if (historyProvider.getAllHistories.length == 0) {
      historyProvider.getHistory(user.token, user.guid, customerProvider);
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: textColor),
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          "History",
          style: getAppBarTextStyle(context),
        ),
        // bottom: PreferredSize(
        //   child: Container(
        //     width: MediaQuery.of(context).size.width,
        //     height: 36,
        //     alignment: Alignment.centerLeft,
        //     padding: const EdgeInsets.symmetric(horizontal: 16),
        //     margin: const EdgeInsets.symmetric(horizontal: 16),
        //     decoration: BoxDecoration(
        //         color: Colors.grey.shade100,
        //         borderRadius: BorderRadius.circular(32)),
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Icon(
        //           FontAwesomeIcons.filter,
        //           size: 12,
        //           color: hintColor,
        //         ),
        //         SizedBox(
        //           width: 16,
        //         ),
        //         Text(
        //           "Last 24 Hours",
        //           style: getDefaultTextStyle(context),
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ],
        //     ),
        //   ),
        //   preferredSize: const Size.fromHeight(36),
        // ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(LoginScreen().routeName),
            icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.black),
          ),
        ],
      ),
      body: historyProvider.isLoading
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
          : historyProvider.getAllHistories.length == 0
              ? Center(
                  child: Text(
                    "No History available",
                    style: getHintTextStyle(context),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () {
                    return historyProvider.refreshHistory(
                        user.token, user.guid, customerProvider);
                  },
                  child: ListView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) =>
                        HistoryItem(historyProvider.getAllHistories[index]),
                    itemCount: historyProvider.getAllHistories.length,
                  ),
                ),
    );
  }
}
