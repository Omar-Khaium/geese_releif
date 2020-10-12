import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/provider/provider_history.dart';
import 'package:geesereleif/src/provider/provider_route.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/view/widget/list_item/item_history.dart';
import 'package:geesereleif/src/view/widget/shimmer/shimmer_history.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  final String routeName = "/history";

  @override
  Widget build(BuildContext context) {
    String customerID = ModalRoute.of(context).settings.arguments as String;
    final routeProvider = Provider.of<RouteProvider>(context, listen: false);
    final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: true);

    routeProvider.init();
    customerProvider.init();
    historyProvider.init();

    Future.delayed(Duration(milliseconds: 1), () {
      if (historyProvider.getAllHistories(customerID).length == 0 &&
          (!historyProvider.hasData.containsKey(customerID) || historyProvider.hasData[customerID]))
        historyProvider.getHistory(customerID);
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
          "Log History",
          style: getAppBarTextStyle(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              routeProvider.logout();
              customerProvider.logout();
              historyProvider.logout();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).popAndPushNamed(LoginScreen().routeName);
            },
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: historyProvider.isLoading
          ? ShimmerHistory()
          : historyProvider.getAllHistories(customerID).length == 0
              ? RefreshIndicator(
                  onRefresh: () => historyProvider.refreshHistory(customerID),
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
                            "No history available",
                            style: getHintTextStyle(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => historyProvider.refreshHistory(customerID),
                  child: ListView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) => HistoryItem(historyProvider.getAllHistories(customerID)[index]),
                    itemCount: historyProvider.getAllHistories(customerID).length,
                  ),
                ),
    );
  }
}
