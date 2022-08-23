import 'package:hive/hive.dart';
part 'visibility.g.dart';

@HiveType(typeId: 15)
enum VisibilityPref {
  @HiveField(0)
  hideDuplicates,
  @HiveField(1)
  showAll,
}

extension ParseToString on VisibilityPref {
  String toShortString() {
    return toString().split('.').last;
  }
}
