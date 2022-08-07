import 'package:hive/hive.dart';
part 'address.g.dart';

@HiveType(typeId: 2)
class Address extends HiveObject {
  @HiveField(0)
  final String address;
  @HiveField(1)
  final String ens;
  @HiveField(2)
  final DateTime addedAt;

  Address(this.address, this.ens, this.addedAt);
}