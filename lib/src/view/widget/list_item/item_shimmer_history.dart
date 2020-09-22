import 'package:flutter/material.dart';
import 'package:geesereleif/src/view/widget/list_item/shimmer_sub_item_history.dart';

class ShimmerHistoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
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
            margin: EdgeInsets.only(bottom: 4, left: 12, right: 12),
          ),
          ListView.builder(
            itemBuilder: (context, index) => ShimmerHistorySubItem(index == 9),
            itemCount: 10,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
