import 'package:geese_releif/src/view/util/constraints.dart';
import 'package:hive/hive.dart';

//part 'user.g.dart';

@HiveType(adapterName: "UserAdapter", typeId: tableUSER)
class User {
  @HiveField(0)
  int id;
  @HiveField(1)
  String guid;
  @HiveField(2)
  String profilePicture;
  @HiveField(3)
  String name;
  @HiveField(3)
  String email;
  @HiveField(4)
  String phone;
  @HiveField(5)
  String password;
  @HiveField(6)
  bool rememberMeEnabled;
  @HiveField(7)
  bool isAuthenticated;
  @HiveField(8)
  String companyLogo;
  @HiveField(9)
  String companyName;
  @HiveField(10)
  String companyGUID;
  @HiveField(11)
  String companyCity;
  @HiveField(12)
  String companyState;
  @HiveField(13)
  int companyZip;

  User(
      {this.id,
        this.guid,
        this.profilePicture,
        this.name,
        this.email,
        this.phone,
        this.password,
        this.rememberMeEnabled,
        this.isAuthenticated,
        this.companyLogo,
        this.companyName,
        this.companyGUID,
        this.companyCity,
        this.companyState,
        this.companyZip});
}
