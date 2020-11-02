import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/provider/provider_history.dart';
import 'package:geesereleif/src/provider/provider_route.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/view/widget/list_item/item_customer.dart';
import 'package:geesereleif/src/view/widget/shimmer/shimmer_customer.dart';
import 'package:provider/provider.dart';

class CustomersScreen extends StatelessWidget {
  final String routeName = "/customers";

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RouteProvider>(context, listen: false);
    final customerProvider = Provider.of<CustomerProvider>(context, listen: true);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);
    final String routeId = ModalRoute.of(context).settings.arguments as String ?? "";

    Future.delayed(Duration(milliseconds: 15), () {
      if (customerProvider.customerList(routeId).isEmpty && !customerProvider.isLoading && customerProvider.isFirstTime) {
        customerProvider.getCustomers(routeId).then((value) {
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
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor,),
          onPressed: (){
            customerProvider.reset();
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Customers".toUpperCase(),
          style: getAppBarTextStyle(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              routeProvider.logout();
              customerProvider.logout();
              historyProvider.logout();
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
      body: customerProvider.isLoading
          ? ShimmerCustomer()
          : customerProvider.customerList(routeId).isEmpty
              ? RefreshIndicator(
                  onRefresh: () => customerProvider.refreshCustomers(routeId, context),
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
                            "No customer available",
                            style: getHintTextStyle(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => customerProvider.refreshCustomers(routeId, context),
                  child: ListView.separated(
                    shrinkWrap: false,
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Divider(
                      color: hintColor,
                      thickness: .25,
                    ),
                    itemBuilder: (context, index) {
                      final Customer customer = customerProvider.customerList(routeId)[index];
                      return CustomerItem(customer);
                    },
                    itemCount: customerProvider.customerList(routeId).length,
                  ),
                ),
    );
  }
}
