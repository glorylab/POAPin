import 'package:hive/hive.dart';
part 'layout.g.dart';

@HiveType(typeId: 3)
enum LayoutPref {
  @HiveField(0)
  grid,
  @HiveField(1)
  list,
  @HiveField(2)
  timeline,
}

extension ParseToString on LayoutPref {
  String toShortString() {
    return toString().split('.').last;
  }
}
