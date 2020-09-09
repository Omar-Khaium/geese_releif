import 'package:geesereleif/src/util/helper.dart';

class Note {
  String note;
  String time;

  Note(this.note, this.time);

  Note.fromJson(Map<String, dynamic> json) {
    try {
      note = json["Notes"];
      time = refineUTC(json["Date"], "yyyy-MM-dd'T'HH:mm:ss.SSS"); //04/14/2020 09:30 PM
    } catch (error) {
      print(error);
    }
  }
}
