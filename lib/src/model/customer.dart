class Customer {
  String guid;
  String name;
  String phone;
  String street;
  String city;
  String state;
  String zip;
  String lead;
  String lastCheckIn;
  int geeseCount;

  Customer(
      {this.guid,
      this.name,
      this.phone,
      this.street,
      this.city,
      this.state,
      this.zip,
      this.lead,
      this.lastCheckIn,
      this.geeseCount});

  Customer.fromJson(Map<String, dynamic> json) {
    guid = json["CustomerId"];
    name = "${json["FirstName"]} ${json["LastName"]}";
    lead = json["Type"];
    phone = json["PrimaryPhone"];
    street = json["Street"];
    city = json["City"];
    state = json["State"];
    zip = json["ZipCode"];
    lastCheckIn = json["CreatedDate"];
    geeseCount = json["CreditScoreValue"];
  }
}
