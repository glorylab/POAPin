import 'package:hive/hive.dart';
import 'package:poapin/data/models/address.dart';
part 'account.g.dart';

@HiveType(typeId: 1)
class Account extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<Address> addresses;
  @HiveField(2)
  final String? eth;

  @HiveField(3)
  final String? ens;

  @HiveField(4)
  final String? name;

  @HiveField(5)
  bool? isDispensed;

  @HiveField(6)
  String? claimLink;

  @HiveField(7)
  String? poapToken;

  Account({
    required this.id,
    required this.addresses,
    this.eth,
    this.ens,
    this.name,
    this.isDispensed,
    this.claimLink,
    this.poapToken,
  });

  factory Account.empty() {
    return Account(id: '', addresses: []);
  }
}
