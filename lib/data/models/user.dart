import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: 10)
class User extends HiveObject {
  @HiveField(0)
  final List<String> eth;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final List<Membership> membership;

  User({
    required this.eth,
    required this.name,
    required this.membership,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.empty() => User(
        eth: [],
        name: '',
        membership: [],
      );
}

@JsonSerializable()
@HiveType(typeId: 11)
class Membership extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String eventID;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String chain;

  Membership({
    required this.id,
    required this.eventID,
    required this.image,
    required this.chain,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Membership.fromJson(Map<String, dynamic> json) =>
      _$MembershipFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MembershipToJson(this);
}

var example = {
  "eth": ["0x5Afc7720b161788f9D833555b7EbC3274FD98Da1"],
  "name": "",
  "membership": [
    {
      "id": "4179969",
      "eventID": "28070",
      "image":
          "https://assets.poap.xyz/public-launch-celebration-of-poapin-2022-logo-1644857492906.png",
      "chain": "gnosis"
    }
  ]
};
