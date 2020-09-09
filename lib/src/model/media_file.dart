class MediaFile {
  String url;
  String date;

  MediaFile(this.url, this.date);

  MediaFile.fromJson(Map<String, dynamic> json) {
    try {
      url = json["Url"];
      date = json["UploadDate"];
    } catch (error) {
      print(error);
    }
  }
}
