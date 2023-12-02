// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalAdapter extends TypeAdapter<Journal> {
  @override
  final int typeId = 21;

  @override
  Journal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Journal(
      id: fields[0] as String,
      title: fields[1] as String,
      desc: fields[2] as String,
      content: fields[3] as String,
      author: fields[4] as String,
      addedAt: fields[5] as DateTime,
      tags: (fields[6] as List).cast<String>(),
      category: fields[7] as String?,
      blocks: (fields[8] as List).cast<JournalBlock>(),
      sort: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Journal obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.blocks)
      ..writeByte(9)
      ..write(obj.sort);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Journal _$JournalFromJson(Map<String, dynamic> json) => Journal(
      id: json['id'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      category: json['category'] as String?,
      blocks: (json['blocks'] as List<dynamic>)
          .map((e) => JournalBlock.fromJson(e as Map<String, dynamic>))
          .toList(),
      sort: json['sort'] as int,
    );

Map<String, dynamic> _$JournalToJson(Journal instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
      'content': instance.content,
      'author': instance.author,
      'addedAt': instance.addedAt.toIso8601String(),
      'tags': instance.tags,
      'category': instance.category,
      'blocks': instance.blocks,
      'sort': instance.sort,
    };
