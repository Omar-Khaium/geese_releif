import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/model/history_item.dart';
import 'package:geesereleif/src/view/util/constraints.dart';

class History {
  String dateTime;
  LogType logType;
  Customer customer;
  List<HistoryItem> items = [];

  History({this.dateTime, this.logType, this.customer, this.items});
}
