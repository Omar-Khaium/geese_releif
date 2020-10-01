import 'package:geesereleif/src/model/media_file.dart';
import 'package:geesereleif/src/model/note.dart';
import 'package:geesereleif/src/util/helper.dart';

class Customer {
  String guid;
  String routeId;
  String name;
  String phone;
  String email;
  String street;
  String city;
  String state;
  String zip;
  String lead;
  String lastCheckIn;
  bool isCheckedIn;
  int geeseCount;
  List<MediaFile> mediaList = [];
  List<Note> noteList = [];

  Customer(
      {this.guid,
      this.routeId,
      this.name,
      this.phone,
      this.email,
      this.street,
      this.city,
      this.state,
      this.zip,
      this.lead,
      this.lastCheckIn,
      this.geeseCount,
      this.mediaList,
      this.noteList});

  Customer.fromJson(
      Map<String, dynamic> customer, List<Map<String, dynamic>> mediaJson, List<Map<String, dynamic>> noteJson, String routeId) {
    try {
      guid = customer["CustomerId"];
      this.routeId = routeId;
      name = customer["Name"];
      lead = customer["GeeseLead"];
      phone = customer["Phone"];
      email = customer["Email"];
      street = customer["Street"];
      city = customer["City"];
      state = customer["State"];
      zip = customer["Zip"];
      lastCheckIn = refineUTC(customer["LastCheckedInTime"].toString().contains(".") ? customer["LastCheckedInTime"] : "${customer["LastCheckedInTime"]}.000", "yyyy-MM-dd'T'HH:mm:ss.SSS");
      geeseCount = customer["GeeseCount"];
      isCheckedIn = customer["IsCheckedIn"];

      noteList = [];
      mediaList = [];
      noteJson.forEach((element) {
        noteList.add(Note.fromJson(Map<String, dynamic>.from(element)));
      });

      mediaJson.forEach((element) {
        mediaList.add(MediaFile.fromJson(Map<String, dynamic>.from(element)));
      });
    } catch (error) {
      print(error);
    }
  }
}
