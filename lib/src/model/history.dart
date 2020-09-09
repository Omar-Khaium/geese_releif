import 'package:geesereleif/src/model/customer.dart';
import 'package:geesereleif/src/model/history_item.dart';
import 'package:geesereleif/src/provider/provider_customer.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';

class History {
  String dateTime;
  LogType logType;
  Customer customer;
  List<HistoryItem> items = [];

  History({this.dateTime, this.logType, this.customer, this.items});

  History.fromJson(
      Map<String, dynamic> map, CustomerProvider customerProvider) {
    dateTime = refineUTC(
        map["Date"].toString().contains(".")
            ? map["Date"]
            : "${map["Date"]}.000",
        "yyyy-MM-dd'T'HH:mm:ss.SSS");
    logType = parseLogType(map["IsCheck"]);
    customer = Customer.fromJson(
        Map<String, dynamic>.from(map["GeeseCustomerList"] ?? {}),
        List<Map<String, dynamic>>.from(map["GeeseMediaList"] ?? []),
        List<Map<String, dynamic>>.from(map["GeeseNoteList"] ?? []),
        "routeId");
    customerProvider.customers.putIfAbsent(customer.guid, () => customer);
  }
}
