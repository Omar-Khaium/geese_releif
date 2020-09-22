import 'package:geesereleif/src/util/constraints.dart';

class MediaFile {
  String url;
  String date;

  MediaFile(this.url, this.date);

  MediaFile.fromJson(Map<String, dynamic> json) {
    try {
      url = apiBaseUrl + json["Url"];
      date = json["UploadDate"];
    } catch (error) {
      print(error);
    }
  }
}
