import 'package:geesereleif/src/util/helper.dart';

class Note {
  String note;
  String time;
  String sendBy;

  Note(this.note, this.time, this.sendBy);

  Note.fromJson(Map<String, dynamic> json) {
    try {
      note = json["Notes"] ?? "";
      sendBy = json["Assigner"] ?? "";
      time = refineUTC(json["Date"].toString().contains(".") ? json["Date"] : "${json["Date"]}.000", "yyyy-MM-dd'T'HH:mm:ss.SSS"); //04/14/2020 09:30 PM
    } catch (error) {
      print(error);
    }
  }
}
