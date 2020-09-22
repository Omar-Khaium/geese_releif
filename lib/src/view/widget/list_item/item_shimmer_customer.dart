import 'package:flutter/material.dart';

class ShimmerCustomerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 12,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
            ),
            margin: EdgeInsets.only(bottom: 4),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
              ),Container(
                width: 20,
                height: 12,
                margin: EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
              ),
            ],
          )
        ],
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 144,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            margin: EdgeInsets.only(bottom: 4),
          ),
          Container(
            width: 72,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            margin: EdgeInsets.only(bottom: 4),
          ),
        Container(
            width: 96,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
          ),
        ],
      ),
    );
  }
}
