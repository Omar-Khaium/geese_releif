import 'package:geesereleif/src/model/history.dart';
import 'package:geesereleif/src/model/history_item.dart';
import 'package:geesereleif/src/view/util/constraints.dart';
import 'package:intl/intl.dart';

List<History> parseHistory(List<History> histories) {
  List<History> list = [];

  for (History history in histories) {
    int position = doesHistoryExists(list, history);
    if (position != -1) {
      list[position]
          .items
          .add(HistoryItem(time: history.dateTime, customer: history.customer, logType: history.logType));
    } else {
      list.add(History(
          dateTime: history.dateTime,
          customer: history.customer, logType: history.logType,
          items: [
            HistoryItem(time: history.dateTime, customer: history.customer, logType: history.logType)
          ]));
    }
  }
  return list;
}

int doesHistoryExists(List<History> histories, History history) {
  for (int i = 0; i < histories.length; i++) {
    if (stringToDateTime(histories[i].dateTime, ULTIMATE_DATE_FORMAT)
            .difference(
                stringToDateTime(history.dateTime, ULTIMATE_DATE_FORMAT))
            .inDays ==
        0) {
      return i;
    }
  }
  return -1;
}

DateTime stringToDateTime(String date, String pattern) {
  DateTime dateTime = DateFormat(pattern).parse(date);
  dateTime = dateTime.add(DateTime.now().timeZoneOffset);
  return dateTime;
}

String dateTimeToStringDate(DateTime date, String pattern) {
  int diff = DateTime.now().difference(date).inDays;
  if (diff == 0) {
    return "Today";
  } else if (diff == 1) {
    return "Yesterday";
  } else {
    return DateFormat(pattern).format(date);
  }
}

String dateTimeToStringTime(DateTime date, String pattern) {
  int diff = DateTime.now().difference(date).inMinutes;
  if (diff <= 60) {
    return "${diff}m ago";
  } else if (diff <= 24*60) {
    return "${diff~/60}h ago";
  } else {
    return DateFormat(pattern).format(date);
  }
}
