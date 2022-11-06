// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HolderAdapter extends TypeAdapter<Holder> {
  @override
  final int typeId = 18;

  @override
  Holder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Holder(
      created: fields[0] as String,
      id: fields[1] as String,
      transferCount: fields[2] as String,
      owner: fields[3] as Owner,
    );
  }

  @override
  void write(BinaryWriter writer, Holder obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.created)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.transferCount)
      ..writeByte(3)
      ..write(obj.owner);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OwnerAdapter extends TypeAdapter<Owner> {
  @override
  final int typeId = 19;

  @override
  Owner read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Owner(
      fields[0] as String,
      fields[1] as int,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Owner obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tokensOwned)
      ..writeByte(2)
      ..write(obj.ens);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Holder _$HolderFromJson(Map<String, dynamic> json) => Holder(
      created: json['created'] as String,
      id: json['id'] as String,
      transferCount: json['transferCount'] as String,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HolderToJson(Holder instance) => <String, dynamic>{
      'created': instance.created,
      'id': instance.id,
      'transferCount': instance.transferCount,
      'owner': instance.owner,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      json['id'] as String,
      json['tokensOwned'] as int,
      json['ens'] as String?,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'id': instance.id,
      'tokensOwned': instance.tokensOwned,
      'ens': instance.ens,
    };

HolderResponse _$HolderResponseFromJson(Map<String, dynamic> json) =>
    HolderResponse(
      json['limit'] as int,
      json['offset'] as int,
      json['total'] as int,
      (json['tokens'] as List<dynamic>?)
          ?.map((e) => Holder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HolderResponseToJson(HolderResponse instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
      'tokens': instance.holders,
    };
