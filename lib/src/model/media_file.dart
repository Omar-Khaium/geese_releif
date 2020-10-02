import 'package:geesereleif/src/util/constraints.dart';
import 'package:geesereleif/src/util/helper.dart';

class MediaFile {
  String url;
  String date;
  String uploadedBy;
  String caption;

  MediaFile(this.url, this.date, this.uploadedBy, this.caption);

  MediaFile.fromJson(Map<String, dynamic> json) {
    try {
      url = apiBaseUrl + json["Url"] ?? "";
      uploadedBy = json["Assigner"] ?? "";
      caption = (json["Notes"] ?? "").toString().replaceAll("</br>", "\n");
      date = refineUTC(json["UploadDate"].toString().contains(".") ? json["UploadDate"] : "${json["UploadDate"]}.000", "yyyy-MM-dd'T'HH:mm:ss.SSS");
    } catch (error) {
      print(error);
    }
  }
}
