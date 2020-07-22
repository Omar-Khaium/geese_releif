import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/history.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:geesereleif/src/view/util/helper.dart';
import 'package:geesereleif/src/view/widget/list_item/sub_item_history.dart';

class HistoryItem extends StatelessWidget {
  final History history;

  HistoryItem(this.history);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateTimeToStringDate(stringToDateTime(history.dateTime, ULTIMATE_DATE_FORMAT), "MM/dd/yyyy"),
            style: getDefaultTextStyle(context, isFocused: true),
          ),
          ListView.builder(
            itemBuilder: (context, index) => HistorySubItem(history.items[index], index==history.items.length-1),
            itemCount: history.items.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
