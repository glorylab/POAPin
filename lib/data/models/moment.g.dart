// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MomentAdapter extends TypeAdapter<Moment> {
  @override
  final int typeId = 16;

  @override
  Moment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Moment(
      momentId: fields[0] as String,
      likesCount: fields[1] as int,
      authorAddress: fields[2] as String,
      authorENS: fields[3] as String?,
      publishDate: fields[4] as String,
      description: fields[5] as String?,
      poapEventID: fields[6] as String,
      bigImageUrl: fields[7] as String,
      smallImageUrl: fields[8] as String?,
      originImageUrl: fields[9] as String?,
      likesAddressList: (fields[10] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Moment obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.momentId)
      ..writeByte(1)
      ..write(obj.likesCount)
      ..writeByte(2)
      ..write(obj.authorAddress)
      ..writeByte(3)
      ..write(obj.authorENS)
      ..writeByte(4)
      ..write(obj.publishDate)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.poapEventID)
      ..writeByte(7)
      ..write(obj.bigImageUrl)
      ..writeByte(8)
      ..write(obj.smallImageUrl)
      ..writeByte(9)
      ..write(obj.originImageUrl)
      ..writeByte(10)
      ..write(obj.likesAddressList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MomentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Moment _$MomentFromJson(Map<String, dynamic> json) => Moment(
      momentId: json['id'] as String,
      likesCount: json['likes'] as int,
      authorAddress: json['address'] as String,
      authorENS: json['ens'] as String?,
      publishDate: json['publishDate'] as String,
      description: json['description'] as String?,
      poapEventID: json['poapId'] as String,
      bigImageUrl: json['1000x1000'] as String,
      smallImageUrl: json['250x250'] as String?,
      originImageUrl: json['originalUrl'] as String?,
      likesAddressList:
          (json['likesA'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MomentToJson(Moment instance) => <String, dynamic>{
      'id': instance.momentId,
      'likes': instance.likesCount,
      'address': instance.authorAddress,
      'ens': instance.authorENS,
      'publishDate': instance.publishDate,
      'description': instance.description,
      'poapId': instance.poapEventID,
      '1000x1000': instance.bigImageUrl,
      '250x250': instance.smallImageUrl,
      'originalUrl': instance.originImageUrl,
      'likesA': instance.likesAddressList,
    };

MomentResponse _$MomentResponseFromJson(Map<String, dynamic> json) =>
    MomentResponse(
      json['status'] as int,
      json['offsetN'] as int?,
      json['total'] as int?,
      (json['photos'] as List<dynamic>?)
          ?.map((e) => Moment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MomentResponseToJson(MomentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'offsetN': instance.offset,
      'total': instance.total,
      'photos': instance.moments,
    };
