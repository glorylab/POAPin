import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:poapin/data/models/journal/block.dart';
import 'package:uuid/uuid.dart';

part 'journal.g.dart';

var uuid = const Uuid();

@JsonSerializable()
@HiveType(typeId: 21)
class Journal extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String desc;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final String author;
  @HiveField(5)
  final DateTime addedAt;
  @HiveField(6)
  final List<String> tags;
  @HiveField(7)
  final String? category;
  @HiveField(8)
  final List<JournalBlock> blocks;
  @HiveField(9)
  final int sort;

  Journal({
    required this.id,
    required this.title,
    required this.desc,
    required this.content,
    required this.author,
    required this.addedAt,
    required this.tags,
    required this.category,
    required this.blocks,
    required this.sort,
  });

  factory Journal.create(String title) {
    return Journal(
      id: const Uuid().v4(),
      title: title,
      desc: '',
      content: '',
      author: '',
      addedAt: DateTime.now(),
      tags: [],
      category: '',
      blocks: [],
      sort: 0,
    );
  }

  factory Journal.fromJson(Map<String, dynamic> json) =>
      _$JournalFromJson(json);
}
