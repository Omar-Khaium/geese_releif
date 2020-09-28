import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/view/screen/screen_history.dart';
import 'package:geesereleif/src/view/screen/screen_login.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/view/widget/list_item/item_customer.dart';
import 'package:geesereleif/src/view/widget/shimmer/shimmer_customer.dart';
import 'package:provider/provider.dart';

class CustomersScreen extends StatelessWidget {
  final String routeName = "/customers";

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    final String routeId = ModalRoute.of(context).settings.arguments as String;

    Future.delayed(Duration(milliseconds: 1), (){
      customerProvider.init();
      if (customerProvider.customerList(routeId).length == 0) {
        customerProvider.getCustomers(routeId);
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
        title: Text(
          "Customers".toUpperCase(),
          style: getAppBarTextStyle(context),
        ),
        actions: [
          ActionChip(
            onPressed: () {
              Navigator.of(context).pushNamed(HistoryScreen().routeName);
            },
            label: Text(
              "History",
              style: getDefaultTextStyle(context),
            ),
            labelPadding: const EdgeInsets.only(right: 4),
            avatar: Icon(
              FontAwesomeIcons.history,
              size: 14,
              color: Colors.grey.shade700,
            ),
            backgroundColor: Colors.grey.shade200,
            elevation: 0,
          ),
          IconButton(
            onPressed: () {
              customerProvider.logout();
              Navigator.of(context).pushReplacementNamed(LoginScreen().routeName);
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
          : customerProvider.customerList(routeId).length == 0
              ? RefreshIndicator(
                  onRefresh: () => customerProvider.refreshCustomers(routeId),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top+kToolbarHeight),
                    alignment: Alignment.center,
                    child: ListView(
                      shrinkWrap: false,
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top+kToolbarHeight),
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
                  onRefresh: () => customerProvider.refreshCustomers(routeId),
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
