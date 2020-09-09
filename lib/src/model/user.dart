class User {
  int id;
  String guid;
  String token;
  String profilePicture;
  String name;
  String email;
  String phone;
  String street;
  String city;
  String state;
  String zip;
  String password;
  String lastUpdatedDate;
  bool rememberMeEnabled;
  bool isAuthenticated;
  String companyLogo;
  String companyName;
  String companyGUID;
  String companyCity;
  String companyState;
  String companyZip;

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
      this.rememberMeEnabled,
      this.isAuthenticated,
      this.companyLogo,
      this.companyName,
      this.companyGUID,
      this.companyCity,
      this.companyState,
      this.companyZip});

  User.fromJson(Map<String, dynamic> json, User old) {
    id = json["emp"]["Id"];
    guid = json["emp"]["UserId"];
    profilePicture = "http://app.rmrcloud.com${json["emp"]["ProfilePicture"]}";
    name = "${json["emp"]["FirstName"]} ${json["emp"]["LastName"]}";
    phone = json["emp"]["Phone"];
    street = json["emp"]["Street"];
    city = json["emp"]["City"];
    state = json["emp"]["State"];
    zip = json["emp"]["ZipCode"];
    lastUpdatedDate = json["emp"]["LastUpdatedDate"];
    email = old.email;
    token = old.token;
    password = old.password;
    companyLogo = "http://app.rmrcloud.com${json["company"]["CompanyLogo"]}";
    companyName = json["company"]["CompanyName"];
    companyGUID = json["company"]["CompanyId  "];
    companyCity = json["company"]["City"];
    companyState = json["company"]["State"];
    companyZip = json["company"]["ZipCode"];
  }
}
