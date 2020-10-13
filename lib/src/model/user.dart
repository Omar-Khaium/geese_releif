import 'package:geesereleif/src/util/constraints.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(adapterName: "UserAdapter", typeId: tableUSER)
class User {
  @HiveField(0)
  int id;
  @HiveField(1)
  String guid;
  @HiveField(2)
  String token;
  @HiveField(3)
  String profilePicture;
  @HiveField(4)
  String name;
  @HiveField(5)
  String email;
  @HiveField(6)
  String phone;
  @HiveField(7)
  String street;
  @HiveField(8)
  String city;
  @HiveField(9)
  String state;
  @HiveField(10)
  String zip;
  @HiveField(11)
  String password;
  @HiveField(12)
  bool isRemembered;
  @HiveField(13)
  String lastUpdatedDate;
  @HiveField(14)
  bool rememberMeEnabled;
  @HiveField(15)
  bool isAuthenticated = false;
  @HiveField(16)
  String companyLogo;
  @HiveField(17)
  String companyName;
  @HiveField(18)
  String companyGUID;
  @HiveField(19)
  String companyCity;
  @HiveField(20)
  String companyState;
  @HiveField(21)
  String companyZip;
  @HiveField(22)
  String role;

  User(
      {this.id,
      this.guid,
      this.token,
      this.profilePicture,
      this.name,
      this.email,
      this.phone,
      this.street,
      this.city,
      this.state,
      this.zip,
      this.lastUpdatedDate,
      this.password,
      this.isRemembered,
      this.rememberMeEnabled,
      this.isAuthenticated,
      this.companyLogo,
      this.companyName,
      this.companyGUID,
      this.companyCity,
      this.companyState,
      this.companyZip,
      this.role});

  User.fromJson(Map<String, dynamic> json, User old) {
    id = json["emp"]["Id"];
    guid = json["emp"]["UserId"];
    profilePicture = "http://app.rmrcloud.com${json["emp"]["ProfilePicture"]}";
    name = "${json["emp"]["FirstName"]} ${json["emp"]["LastName"]}".trim();
    phone = json["emp"]["Phone"];
    street = json["emp"]["Street"];
    city = json["emp"]["City"];
    state = json["emp"]["State"];
    zip = json["emp"]["ZipCode"];
    lastUpdatedDate = json["emp"]["LastUpdatedDate"];
    email = old.email;
    token = old.token;
    isRemembered = old.isRemembered;
    isAuthenticated = true;
    password = old.password;
    companyLogo = "http://app.rmrcloud.com${json["company"]["CompanyLogo"]}";
    companyName = json["company"]["CompanyName"];
    companyGUID = json["company"]["CompanyId  "];
    companyCity = json["company"]["City"];
    companyState = json["company"]["State"];
    companyZip = json["company"]["ZipCode"];
    role = json["emp"]["Role"];
  }
}
