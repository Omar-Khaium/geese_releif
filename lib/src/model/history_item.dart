import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/util/constraints.dart';

class HistoryItem {
  String time;
  LogType logType;
  Customer customer;

  HistoryItem({this.time, this.logType, this.customer});
}
