import 'package:flutter/material.dart';

class ShimmerRouteItem extends StatelessWidget {
  final bool isOdd;

  ShimmerRouteItem(this.isOdd);

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
      title: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: !isOdd ? MediaQuery.of(context).size.width*.65 : MediaQuery.of(context).size.width*.5,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }
}
