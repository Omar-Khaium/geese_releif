import 'package:flutter/material.dart';
import 'package:geesereleif/src/view/widget/list_item/item_shimmer_customer.dart';

class ShimmerCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ShimmerCustomerItem(),
      itemCount: 10,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey.shade100,
        thickness: .5,
      ),
    );
  }
}
