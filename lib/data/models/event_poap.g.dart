// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_poap.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventPOAPResponseAdapter extends TypeAdapter<EventPOAPResponse> {
  @override
  final int typeId = 14;

  @override
  EventPOAPResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventPOAPResponse(
      limit: fields[0] as int,
      offset: fields[1] as int,
      total: fields[2] as int,
      tokens: (fields[3] as List).cast<EventPOAP>(),
    );
  }

  @override
  void write(BinaryWriter writer, EventPOAPResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.limit)
      ..writeByte(1)
      ..write(obj.offset)
      ..writeByte(2)
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.tokens);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventPOAPResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EventPOAPAdapter extends TypeAdapter<EventPOAP> {
  @override
  final int typeId = 13;

  @override
  EventPOAP read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventPOAP(
      created: fields[0] as String,
      id: fields[1] as String,
      transferCount: fields[2] as String,
      owner: fields[3] as EventPOAPOwner,
    );
  }

  @override
  void write(BinaryWriter writer, EventPOAP obj) {
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
      other is EventPOAPAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EventPOAPOwnerAdapter extends TypeAdapter<EventPOAPOwner> {
  @override
  final int typeId = 12;

  @override
  EventPOAPOwner read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventPOAPOwner(
      id: fields[0] as String,
      tokensOwned: fields[1] as int,
      ens: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EventPOAPOwner obj) {
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
      other is EventPOAPOwnerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPOAPResponse _$EventPOAPResponseFromJson(Map<String, dynamic> json) =>
    EventPOAPResponse(
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      total: json['total'] as int,
      tokens: (json['tokens'] as List<dynamic>)
          .map((e) => EventPOAP.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventPOAPResponseToJson(EventPOAPResponse instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
      'tokens': instance.tokens,
    };

EventPOAP _$EventPOAPFromJson(Map<String, dynamic> json) => EventPOAP(
      created: json['created'] as String,
      id: json['id'] as String,
      transferCount: json['transferCount'] as String,
      owner: EventPOAPOwner.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventPOAPToJson(EventPOAP instance) => <String, dynamic>{
      'created': instance.created,
      'id': instance.id,
      'transferCount': instance.transferCount,
      'owner': instance.owner,
    };

EventPOAPOwner _$EventPOAPOwnerFromJson(Map<String, dynamic> json) =>
    EventPOAPOwner(
      id: json['id'] as String,
      tokensOwned: json['tokensOwned'] as int,
      ens: json['ens'] as String,
    );

Map<String, dynamic> _$EventPOAPOwnerToJson(EventPOAPOwner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tokensOwned': instance.tokensOwned,
      'ens': instance.ens,
    };
