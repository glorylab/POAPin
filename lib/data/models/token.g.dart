// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenAdapter extends TypeAdapter<Token> {
  @override
  final int typeId = 6;

  @override
  Token read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Token(
      fields[4] as Event,
      fields[0] as String,
      fields[1] as String,
      fields[2] as String?,
      fields[3] as String?,
      fields[5] as Supply?,
      fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Token obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.tokenId)
      ..writeByte(1)
      ..write(obj.owner)
      ..writeByte(2)
      ..write(obj.created)
      ..writeByte(3)
      ..write(obj.layer)
      ..writeByte(4)
      ..write(obj.event)
      ..writeByte(5)
      ..write(obj.supply)
      ..writeByte(6)
      ..write(obj.chain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 7;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      fields[2] as String,
      fields[0] as String,
      fields[3] as String,
      fields[1] as String,
      fields[4] as DateTime?,
      fields[5] as DateTime?,
      fields[6] as int,
      fields[7] as int,
      fields[8] as int,
      fields[9] as int,
      fields[10] as int,
      fields[11] as int?,
      fields[14] as String?,
      fields[12] as String?,
      fields[13] as String?,
      fields[15] as DateTime?,
      fields[16] as String?,
      fields[17] as String?,
      (fields[18] as List?)?.cast<Tag>(),
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.fancyID)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.expiryDate)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.year)
      ..writeByte(8)
      ..write(obj.realYear)
      ..writeByte(9)
      ..write(obj.month)
      ..writeByte(10)
      ..write(obj.day)
      ..writeByte(11)
      ..write(obj.supply)
      ..writeByte(12)
      ..write(obj.country)
      ..writeByte(13)
      ..write(obj.city)
      ..writeByte(14)
      ..write(obj.eventUrl)
      ..writeByte(15)
      ..write(obj.endDate)
      ..writeByte(16)
      ..write(obj.signerIP)
      ..writeByte(17)
      ..write(obj.signer)
      ..writeByte(18)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SupplyAdapter extends TypeAdapter<Supply> {
  @override
  final int typeId = 8;

  @override
  Supply read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Supply(
      fields[0] as int?,
      fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Supply obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.total)
      ..writeByte(1)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupplyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      Event.fromJson(json['event'] as Map<String, dynamic>),
      json['tokenId'] as String,
      json['owner'] as String,
      json['created'] as String?,
      json['layer'] as String?,
      Token._handleSupply(json['supply']),
      json['chain'] as String?,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'tokenId': instance.tokenId,
      'owner': instance.owner,
      'created': instance.created,
      'layer': instance.layer,
      'event': instance.event,
      'supply': instance.supply,
      'chain': instance.chain,
    };

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      json['fancy_id'] as String,
      json['name'] as String,
      json['image_url'] as String,
      json['description'] as String,
      Event._timeConverter(json['start_date']),
      Event._timeConverter(json['expiry_date']),
      json['id'] as int,
      json['year'] as int,
      Event._defaultInt(json['realYear']),
      Event._defaultInt(json['month']),
      Event._defaultInt(json['day']),
      json['supply'] as int?,
      json['event_url'] as String?,
      json['country'] as String?,
      json['city'] as String?,
      Event._timeConverter(json['end_date']),
      json['signer_ip'] as String?,
      json['signer'] as String?,
      Event._defaultTag(json['tags']),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'fancy_id': instance.fancyID,
      'image_url': instance.imageUrl,
      'start_date': instance.startDate?.toIso8601String(),
      'expiry_date': instance.expiryDate?.toIso8601String(),
      'id': instance.id,
      'year': instance.year,
      'realYear': instance.realYear,
      'month': instance.month,
      'day': instance.day,
      'supply': instance.supply,
      'country': instance.country,
      'city': instance.city,
      'event_url': instance.eventUrl,
      'end_date': instance.endDate?.toIso8601String(),
      'signer_ip': instance.signerIP,
      'signer': instance.signer,
      'tags': instance.tags,
    };

Supply _$SupplyFromJson(Map<String, dynamic> json) => Supply(
      json['total'] as int?,
      json['order'] as int?,
    );

Map<String, dynamic> _$SupplyToJson(Supply instance) => <String, dynamic>{
      'total': instance.total,
      'order': instance.order,
    };
