import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:geesereleif/src/model/history.dart';
import 'package:geesereleif/src/model/history_item.dart';
import 'package:geesereleif/src/util/constraints.dart';
import 'package:intl/intl.dart';

List<History> parseHistory(List<History> histories) {
  List<History> list = [];

  for (History history in histories) {
    int position = doesHistoryExists(list, history);
    if (position != -1) {
      list[position].items.add(HistoryItem(
          time: history.dateTime,
          customer: history.customer,
          logType: history.logType));
    } else {
      list.add(History(
          dateTime: history.dateTime,
          customer: history.customer,
          logType: history.logType,
          items: [
            HistoryItem(
                time: history.dateTime,
                customer: history.customer,
                logType: history.logType)
          ]));
    }
  }
  return list;
}

int doesHistoryExists(List<History> histories, History history) {
  for (int i = 0; i < histories.length; i++) {
    if (stringToDateTime(histories[i].dateTime)
            .difference(stringToDateTime(history.dateTime))
            .inDays ==
        0) {
      return i;
    }
  }
  return -1;
}

DateTime stringToDateTime(String date) {
  DateTime dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date.contains(".") ? date : "$date.000");
  return dateTime;
}

String dateTimeToStringDate(DateTime date, String pattern) =>
    DateFormat(pattern).format(date);

String dateTimeToStringTime(DateTime date, String pattern) =>
    DateFormat(pattern).format(date);

String dateTimeToFriendlyDate(DateTime date, String pattern) {
  try {
    int diff = DateTime.now().difference(date).inDays;
    if (diff == 0) {
      return "Today";
    } else if (diff == 1) {
      return "Yesterday";
    } else {
      return DateFormat(pattern).format(date);
    }
  } catch (error) {
    return "-";
  }
}

String dateTimeToFriendlyTime(DateTime date, String pattern) {
  try {
    int diff = DateTime.now().difference(date).inMinutes;
    if (diff < 0) {
      return "0m ago";
    }
    else if (diff >=0 && diff <= 60) {
      return "${diff}m ago";
    } else if (diff <= 24 * 60) {
      return "${diff ~/ 60}h ago";
    } else {
      return DateFormat(pattern).format(date);
    }
  } catch (error) {
    return "-";
  }
}

String refineUTC(String date, String pattern) {
  DateTime dateTime = DateFormat(pattern).parse(date);
  dateTime = dateTime.add(DateTime.now().timeZoneOffset);
  return dateTime.toIso8601String();
}

LogType parseLogType(String log) {
  switch (log) {
    case "":
      return LogType.Active;
    case "CheckIn":
      return LogType.CheckedIn;
    case "CheckOut":
      return LogType.CheckedOut;
    default:
      return LogType.CheckedOut;
  }
}

String constructAddress(String street, String city, String state, String zip) {
  String line_1 = refineString(street).trim();
  String zipCode = refineString(zip).trim();
  String stateName = refineString(state).trim();
  String cityName = refineString(city).trim();
  String line_2 =
      "${zipCode.isEmpty ? (stateName.isEmpty ? (cityName.isEmpty ? "" : cityName) : "$cityName, $stateName") : (stateName.isEmpty ? (cityName.isEmpty ? zipCode : "$cityName, $zipCode") : "$cityName, $stateName $zipCode")}";
  return "${line_2.isEmpty ? line_1 : "$line_1\n$line_2"}";
}

String refineString(String value) {
  return value ?? "";
}

void networkERROR({@required BuildContext context}) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    backgroundColor: Colors.red.shade400,
    duration: Duration(seconds: 4),
    boxShadows: [
      BoxShadow(
        color: Colors.red.shade100,
        offset: Offset(0.0, 0.0),
        blurRadius: 1.0,
      )
    ],
    title: "No Internet Connection",
    message: "Please connect to an active network",
  )..show(context);
}

void alertERROR({@required BuildContext context, @required String message}) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    backgroundColor: Colors.red.shade300,
    duration: Duration(seconds: 4),
    boxShadows: [
      BoxShadow(
        color: Colors.red.shade100,
        offset: Offset(0.0, 0.0),
        blurRadius: 1.0,
      )
    ],
    title: "Error",
    message: message,
  )..show(context);
}

void alertSuccess({@required BuildContext context, @required String message}) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    backgroundColor: Colors.blue,
    duration: Duration(seconds: 4),
    boxShadows: [
      BoxShadow(
        color: Colors.blue.shade100,
        offset: Offset(0.0, 0.0),
        blurRadius: 1.0,
      )
    ],
    title: "Congratulations",
    message: message,
  )..show(context);
}
