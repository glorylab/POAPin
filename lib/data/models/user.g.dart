// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 10;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      eth: (fields[0] as List).cast<String>(),
      name: fields[1] as String,
      membership: (fields[2] as List).cast<Membership>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.eth)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.membership);
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

class MembershipAdapter extends TypeAdapter<Membership> {
  @override
  final int typeId = 11;

  @override
  Membership read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Membership(
      id: fields[0] as String,
      eventID: fields[1] as String,
      image: fields[2] as String,
      chain: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Membership obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.eventID)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.chain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MembershipAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      eth: (json['eth'] as List<dynamic>).map((e) => e as String).toList(),
      name: json['name'] as String,
      membership: (json['membership'] as List<dynamic>)
          .map((e) => Membership.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'eth': instance.eth,
      'name': instance.name,
      'membership': instance.membership,
    };

Membership _$MembershipFromJson(Map<String, dynamic> json) => Membership(
      id: json['id'] as String,
      eventID: json['eventID'] as String,
      image: json['image'] as String,
      chain: json['chain'] as String,
    );

Map<String, dynamic> _$MembershipToJson(Membership instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventID': instance.eventID,
      'image': instance.image,
      'chain': instance.chain,
    };
