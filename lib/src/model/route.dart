class Routes {
  String guid;
  String name;
  String lastVisited;

  Routes(this.guid, this.name, this.lastVisited);

  Routes.fromJson(Map<String, dynamic> json) {
    guid = json["RouteId"];
    name = json["Name"];
    lastVisited = json["LastVisit"];
  }
}
