// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      guid: fields[1] as String,
      token: fields[2] as String,
      profilePicture: fields[3] as String,
      name: fields[4] as String,
      email: fields[5] as String,
      phone: fields[6] as String,
      street: fields[7] as String,
      city: fields[8] as String,
      state: fields[9] as String,
      zip: fields[10] as String,
      lastUpdatedDate: fields[13] as String,
      password: fields[11] as String,
      isRemembered: fields[12] as bool,
      rememberMeEnabled: fields[14] as bool,
      isAuthenticated: fields[15] as bool,
      companyLogo: fields[16] as String,
      companyName: fields[17] as String,
      companyGUID: fields[18] as String,
      companyCity: fields[19] as String,
      companyState: fields[20] as String,
      companyZip: fields[21] as String,
      role: fields[22] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.guid)
      ..writeByte(2)
      ..write(obj.token)
      ..writeByte(3)
      ..write(obj.profilePicture)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.street)
      ..writeByte(8)
      ..write(obj.city)
      ..writeByte(9)
      ..write(obj.state)
      ..writeByte(10)
      ..write(obj.zip)
      ..writeByte(11)
      ..write(obj.password)
      ..writeByte(12)
      ..write(obj.isRemembered)
      ..writeByte(13)
      ..write(obj.lastUpdatedDate)
      ..writeByte(14)
      ..write(obj.rememberMeEnabled)
      ..writeByte(15)
      ..write(obj.isAuthenticated)
      ..writeByte(16)
      ..write(obj.companyLogo)
      ..writeByte(17)
      ..write(obj.companyName)
      ..writeByte(18)
      ..write(obj.companyGUID)
      ..writeByte(19)
      ..write(obj.companyCity)
      ..writeByte(20)
      ..write(obj.companyState)
      ..writeByte(21)
      ..write(obj.companyZip)
      ..writeByte(22)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
