import 'package:hive/hive.dart';
part 'shape.g.dart';

@HiveType(typeId: 4)
enum ShapePref {
  @HiveField(0)
  square,
  @HiveField(1)
  round,
}

extension ParseToString on ShapePref {
  String toShortString() {
    return toString().split('.').last;
  }
}
