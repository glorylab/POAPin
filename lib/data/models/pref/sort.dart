import 'package:hive/hive.dart';
part 'sort.g.dart';

@HiveType(typeId: 5)
enum SortPref {
  @HiveField(0)
  timeAsc,
  @HiveField(1)
  timeDesc,
}

extension ParseToString on SortPref {
  String toShortString() {
    return toString().split('.').last;
  }
}
