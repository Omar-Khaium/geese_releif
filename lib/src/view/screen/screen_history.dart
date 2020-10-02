import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/provider/provider_history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/view/widget/list_item/item_history.dart';
import 'package:geesereleif/src/view/widget/shimmer/shimmer_history.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HistoryScreen extends StatelessWidget {
  final String routeName = "/history";

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: true);


    Future.delayed(Duration(milliseconds: 1), (){
      historyProvider.init();
      if (historyProvider.getAllHistories.length == 0) {
        historyProvider.getHistory(customerProvider);
      }
    });
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
        actions: [
          IconButton(
            onPressed: () {
              historyProvider.logout();
              Navigator.of(context).pushReplacementNamed(LoginScreen().routeName);
            },
            icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.black),
          ),
        ],
      ),
      body: historyProvider.isLoading
          ? ShimmerHistory()
          : historyProvider.getAllHistories.length == 0
              ? RefreshIndicator(
                  onRefresh: () => historyProvider.refreshHistory(customerProvider),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight),
                    alignment: Alignment.center,
                    child: ListView(
                      shrinkWrap: false,
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight),
                          alignment: Alignment.center,
                          child: Text(
                            "No route available",
                            style: getHintTextStyle(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => historyProvider.refreshHistory(customerProvider),
                  child: ListView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) => HistoryItem(historyProvider.getAllHistories[index]),
                    itemCount: historyProvider.getAllHistories.length,
                  ),
                ),
    );
  }
}
