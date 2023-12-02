import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'block.g.dart';

var uuid = const Uuid();

@JsonSerializable()
@HiveType(typeId: 20)
class JournalBlock extends HiveObject {
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
  final String type;
  @HiveField(7)
  final String? url;
  @HiveField(8)
  final String? media;
  @HiveField(9)
  final String? journalId;
  @HiveField(10)
  final int sort;

  JournalBlock({
    required this.id,
    required this.title,
    required this.desc,
    required this.content,
    required this.author,
    required this.addedAt,
    required this.type,
    required this.url,
    required this.media,
    required this.journalId,
    required this.sort,
  });

  factory JournalBlock.create(String title) {
    return JournalBlock(
      id: const Uuid().v4(),
      title: title,
      desc: '',
      content: '',
      author: '',
      addedAt: DateTime.now(),
      type: 'text',
      url: '',
      media: '',
      journalId: '',
      sort: 0,
    );
  }

  factory JournalBlock.fromJson(Map<String, dynamic> json) =>
      _$JournalBlockFromJson(json);
}
