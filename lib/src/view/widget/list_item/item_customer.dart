import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/view/screen/screen_customer_details.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';
import 'package:maps_launcher/maps_launcher.dart';

class CustomerItem extends StatelessWidget {
  final Customer customer;

  CustomerItem(this.customer);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 0),
      visualDensity: VisualDensity.compact,
      onTap: () {
        Navigator.of(context).pushNamed(CustomerDetailsScreen().routeName, arguments: customer.guid);
      },
      title: Text(
        customer.name,
        style: getDefaultTextStyle(context, isFocused: true),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Visibility(
        visible: (customer.phone ?? "").isNotEmpty,
        child: Text(
          customer.phone ?? "",
          style: getCaptionTextStyle(context),
        ),
      ),
      trailing: Visibility(
        visible: constructAddress(customer.street, customer.city, customer.state, customer.zip).isNotEmpty,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            MapsLauncher.launchQuery(
              constructAddress(customer.street, customer.city, customer.state, customer.zip),
            );
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .35,
            child: Text(
              constructAddress(customer.street, customer.city, customer.state, customer.zip),
              style: getClickableTextStyle(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
