class Routes {
  String guid;
  String name;

  Routes(this.guid, this.name);

  Routes.fromJson(Map<String,dynamic> json) {
    guid = json["value"];
    name = json["text"];
  }
}