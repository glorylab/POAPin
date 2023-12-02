// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalBlockAdapter extends TypeAdapter<JournalBlock> {
  @override
  final int typeId = 20;

  @override
  JournalBlock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalBlock(
      id: fields[0] as String,
      title: fields[1] as String,
      desc: fields[2] as String,
      content: fields[3] as String,
      author: fields[4] as String,
      addedAt: fields[5] as DateTime,
      type: fields[6] as String,
      url: fields[7] as String?,
      media: fields[8] as String?,
      journalId: fields[9] as String?,
      sort: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, JournalBlock obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.desc)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.author)
      ..writeByte(5)
      ..write(obj.addedAt)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.url)
      ..writeByte(8)
      ..write(obj.media)
      ..writeByte(9)
      ..write(obj.journalId)
      ..writeByte(10)
      ..write(obj.sort);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalBlockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalBlock _$JournalBlockFromJson(Map<String, dynamic> json) => JournalBlock(
      id: json['id'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
      type: json['type'] as String,
      url: json['url'] as String?,
      media: json['media'] as String?,
      journalId: json['journalId'] as String?,
      sort: json['sort'] as int,
    );

Map<String, dynamic> _$JournalBlockToJson(JournalBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
      'content': instance.content,
      'author': instance.author,
      'addedAt': instance.addedAt.toIso8601String(),
      'type': instance.type,
      'url': instance.url,
      'media': instance.media,
      'journalId': instance.journalId,
      'sort': instance.sort,
    };
