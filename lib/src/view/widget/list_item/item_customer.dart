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
      onTap: () {
        Navigator.of(context).pushNamed(CustomerDetailsScreen().routeName,
            arguments: customer.guid);
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
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Text(
                  customer.name,
                  style: getDefaultTextStyle(context, isFocused: true),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                customer.lead,
                style: getCaptionTextStyle(context),
              ),
              SizedBox(
                height: 6,
              ),
            ],
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              MapsLauncher.launchQuery(
                  "${customer.street}\n${customer.city}, ${customer.state} ${customer.zip}");
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .35,
              child: Text(
                "${customer.street}\n${customer.city}, ${customer.state} ${customer.zip}",
                style: getClickableTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            customer.lastCheckIn.startsWith("20")
                ? "${dateTimeToStringDate(stringToDateTime(customer.lastCheckIn), "dd MMM, yyyy")} ${dateTimeToStringTime(stringToDateTime(customer.lastCheckIn), "hh:mm a")}"
                : "no check-in record found",
            style: getCaptionTextStyle(context),
          ),
          Text(
            customer.phone,
            style: getCaptionTextStyle(context),
          ),
        ],
      ),
    );
  }
}