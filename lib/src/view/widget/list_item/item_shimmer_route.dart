import 'package:flutter/material.dart';

class ShimmerRouteItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      trailing: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
        ),
      ),
      title: Container(
        width: 72,
        height: 12,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
      ),
    );
  }
}
