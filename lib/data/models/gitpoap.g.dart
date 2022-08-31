// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gitpoap.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GitPOAPAdapter extends TypeAdapter<GitPOAP> {
  @override
  final int typeId = 17;

  @override
  GitPOAP read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GitPOAP(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[3] as int,
      fields[4] as String,
      fields[5] as String,
      fields[6] as int,
      fields[7] as String,
      fields[8] as String,
      (fields[9] as List).cast<String>(),
      fields[10] as String,
      fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GitPOAP obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.gitPOAPID)
      ..writeByte(1)
      ..write(obj.gitPOAPEventID)
      ..writeByte(2)
      ..write(obj.poapTokenID)
      ..writeByte(3)
      ..write(obj.poapEventID)
      ..writeByte(4)
      ..write(obj.poapEventFancyID)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.year)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.imageURL)
      ..writeByte(9)
      ..write(obj.repositories)
      ..writeByte(10)
      ..write(obj.earnedAt)
      ..writeByte(11)
      ..write(obj.mintedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GitPOAPAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitPOAP _$GitPOAPFromJson(Map<String, dynamic> json) => GitPOAP(
      json['gitPoapId'] as int,
      json['gitPoapEventId'] as int,
      json['poapTokenId'] as String,
      json['poapEventId'] as int,
      json['poapEventFancyId'] as String,
      json['name'] as String,
      json['year'] as int,
      json['description'] as String,
      json['imageUrl'] as String,
      (json['repositories'] as List<dynamic>).map((e) => e as String).toList(),
      json['earnedAt'] as String,
      json['mintedAt'] as String,
    );

Map<String, dynamic> _$GitPOAPToJson(GitPOAP instance) => <String, dynamic>{
      'gitPoapId': instance.gitPOAPID,
      'gitPoapEventId': instance.gitPOAPEventID,
      'poapTokenId': instance.poapTokenID,
      'poapEventId': instance.poapEventID,
      'poapEventFancyId': instance.poapEventFancyID,
      'name': instance.name,
      'year': instance.year,
      'description': instance.description,
      'imageUrl': instance.imageURL,
      'repositories': instance.repositories,
      'earnedAt': instance.earnedAt,
      'mintedAt': instance.mintedAt,
    };
