import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/provider/provider_history.dart';
import 'package:geesereleif/src/provider/provider_route.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';
import 'package:geesereleif/src/view/screen/screen_customers.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/view/widget/shimmer/shimmer_route.dart';
import 'package:provider/provider.dart';

class RoutesScreen extends StatelessWidget {
  final String routeName = "/routes";

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RouteProvider>(context, listen: true);
    final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      if (routeProvider.routeList.isEmpty && (!routeProvider.isLoading) && routeProvider.isFirstTime) {

        routeProvider.init();
        customerProvider.init();
        historyProvider.init();

        routeProvider.getRoutes().then((value) {
          switch (value) {
            case 200:
              break;
            case 400:
            case 500:
              alertERROR(context: context, message: "Something went wrong.");
              break;
            case 503:
              networkERROR(context: context);
              break;
            default:
              alertERROR(context: context, message: "Something went wrong.");
              break;
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
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
          IconButton(
            onPressed: () {
              routeProvider.logout();
              customerProvider.logout();
              historyProvider.logout();
              Navigator.of(context).pushReplacementNamed(LoginScreen().routeName);
            },
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: routeProvider.isLoading
          ? ShimmerRoute()
          : routeProvider.routeList.isEmpty
              ? RefreshIndicator(
                  onRefresh: () => routeProvider.refreshRoutes(context),
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
                  onRefresh: () => routeProvider.refreshRoutes(context),
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
                        routeProvider.reset();
                        customerProvider.reset();
                        Navigator.of(context).pushNamed(CustomersScreen().routeName, arguments: routeProvider.routeList[index].guid);
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
