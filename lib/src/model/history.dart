import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/history_item.dart';
import 'package:geesereleif/src/util/constraints.dart';

class History {
  String dateTime;
  LogType logType;
  String customerGUID;
  String checkedBy;
  int geeseCount;
  List<HistoryItem> items = [];

  History({@required this.dateTime, @required this.logType, @required this.customerGUID, @required this.checkedBy, @required this.geeseCount, this.items});
}
