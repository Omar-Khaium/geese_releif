import 'package:flutter/cupertino.dart';
import 'package:geesereleif/src/util/constraints.dart';

class HistoryItem {
  String time;
  LogType logType;
  String customerGuid;
  String checkedBy;
  int geeseCount;

  HistoryItem(
      {@required this.time, @required this.logType, @required this.customerGuid, @required this.checkedBy, @required this.geeseCount});
}
