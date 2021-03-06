import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/model/history_item.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';

class HistorySubItem extends StatelessWidget {
  final HistoryItem historyItem;
  final bool isLastItem;

  HistorySubItem(this.historyItem, this.isLastItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: historyItem.logType == LogType.CheckedOut ? 64 : 84,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Transform.rotate(
                      child: Icon(
                        historyItem.logType == LogType.Active ? Icons.fiber_manual_record : Icons.transit_enterexit,
                        color: historyItem.logType == LogType.Active || historyItem.logType == LogType.CheckedIn
                            ? Colors.green
                            : Colors.red,
                      ),
                      angle: historyItem.logType == LogType.CheckedIn ? -pi / 2 : -pi,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      dateTimeToStringTime(stringToDateTime(historyItem.time), "hh:mm a") ?? "-",
                      style: getCaptionTextStyle(context),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 4),
                    child: Visibility(
                      visible: !isLastItem,
                      child: VerticalDivider(
                        color: textColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.only(bottom: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.solidUser,
                        size: 12,
                        color: textColor,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        child: Text(
                          historyItem.checkedBy ?? "-",
                          style: getDefaultTextStyle(context, isFocused: false),
                          overflow: TextOverflow.ellipsis,
                        ),
                        width: MediaQuery.of(context).size.width * .7 - 72,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: historyItem.logType!=LogType.CheckedOut,
                    child: SizedBox(
                      height: 8,
                    ),
                  ),
                  Visibility(
                    visible: historyItem.logType!=LogType.CheckedOut,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.crow,
                          size: 12,
                          color: textColor,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          child: Text(
                            historyItem.geeseCount.toString() ?? "-",
                            style: getDefaultTextStyle(context, isFocused: false),
                            overflow: TextOverflow.ellipsis,
                          ),
                          width: MediaQuery.of(context).size.width * .7 - 72,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
