import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geesereleif/src/model/history_item.dart';
import 'package:geesereleif/src/view/screen/screen_customer_details.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';

class ShimmerHistorySubItem extends StatelessWidget {
  final bool isLastItem;

  ShimmerHistorySubItem(this.isLastItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 12),
      height: 80,
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
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      margin: EdgeInsets.only(bottom: 4),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 72,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      margin: EdgeInsets.only(bottom: 4),
                    )
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
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.only(bottom: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                        ),
                        margin: EdgeInsets.only(bottom: 4),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        child: Container(
                          width: 144,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                          ),
                          margin: EdgeInsets.only(bottom: 4),
                        ),
                        width: MediaQuery.of(context).size.width * .7 - 72,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                        ),
                        margin: EdgeInsets.only(bottom: 4),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        child: Container(
                          width: 72,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                          ),
                          margin: EdgeInsets.only(bottom: 4),
                        ),
                        width: MediaQuery.of(context).size.width * .7 - 72,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
