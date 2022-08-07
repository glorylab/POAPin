import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'tag.g.dart';

var uuid = const Uuid();

@JsonSerializable()
@HiveType(typeId: 9)
class Tag extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String desc;
  @HiveField(3)
  final String author;
  @HiveField(4)
  final DateTime addedAt;

  Tag(
      {required this.id,
      required this.name,
      required this.desc,
      required this.author,
      required this.addedAt});

  factory Tag.create(String name) {
    return Tag(
        id: const Uuid().v4(),
        name: name,
        desc: '',
        author: '',
        addedAt: DateTime.now());
  }
}
