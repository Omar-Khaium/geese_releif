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
      lastUpdatedDate: fields[12] as String,
      password: fields[11] as String,
      isRemembered: fields[21] as bool,
      rememberMeEnabled: fields[13] as bool,
      isAuthenticated: fields[14] as bool,
      companyLogo: fields[15] as String,
      companyName: fields[16] as String,
      companyGUID: fields[17] as String,
      companyCity: fields[18] as String,
      companyState: fields[19] as String,
      companyZip: fields[20] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(22)
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
      ..writeByte(21)
      ..write(obj.isRemembered)
      ..writeByte(12)
      ..write(obj.lastUpdatedDate)
      ..writeByte(13)
      ..write(obj.rememberMeEnabled)
      ..writeByte(14)
      ..write(obj.isAuthenticated)
      ..writeByte(15)
      ..write(obj.companyLogo)
      ..writeByte(16)
      ..write(obj.companyName)
      ..writeByte(17)
      ..write(obj.companyGUID)
      ..writeByte(18)
      ..write(obj.companyCity)
      ..writeByte(19)
      ..write(obj.companyState)
      ..writeByte(20)
      ..write(obj.companyZip);
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
