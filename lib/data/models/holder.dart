import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'holder.g.dart';

@JsonSerializable()
@HiveType(typeId: 18)
class Holder extends HiveObject {
  @HiveField(0)
  final String created;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String transferCount;

  @HiveField(3)
  final Owner owner;

  Holder({
    required this.created,
    required this.id,
    required this.transferCount,
    required this.owner,
  });

  factory Holder.fromJson(Map<String, dynamic> json) => _$HolderFromJson(json);

  Map<String, dynamic> toJson() => _$HolderToJson(this);

  factory Holder.empty() => Holder(
        created: '',
        id: '0',
        transferCount: '0',
        owner: Owner.empty(),
      );
}

@JsonSerializable()
@HiveType(typeId: 19)
class Owner {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int tokensOwned;
  @HiveField(2)
  final String? ens;

  Owner(
    this.id,
    this.tokensOwned,
    this.ens,
  );

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);

  factory Owner.empty() => Owner(
        '0x0000000000000000000000000000000000000000',
        0,
        null,
      );
}

@JsonSerializable()
class HolderResponse {
  final int limit;
  final int offset;
  final int total;

  @JsonKey(name: 'tokens')
  final List<Holder>? holders;

  HolderResponse(
    this.limit,
    this.offset,
    this.total,
    this.holders,
  );

  factory HolderResponse.fromJson(Map<String, dynamic> json) =>
      _$HolderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HolderResponseToJson(this);
}

var example = {
  "limit": 10,
  "offset": 0,
  "total": 369,
  "tokens": [
    {
      "created": "2022-05-22 09:35:25",
      "id": "5028248",
      "owner": {
        "id": "0xed7e736851bc65967a65cf1134300c27f39b7648",
        "tokensOwned": 5,
        "ens": "rossonerii.eth"
      },
      "transferCount": "1"
    },
    {
      "created": "2022-04-10 05:24:05",
      "id": "4675247",
      "owner": {
        "id": "0x7243195a9a1049aaa0b3a5ff461b816f6cf09d63",
        "tokensOwned": 1
      },
      "transferCount": "1"
    },
    {
      "created": "2022-01-23 22:54:05",
      "id": "3685813",
      "owner": {
        "id": "0x9cbbda094cc0fa9217b783ace7f0c103a8265cc4",
        "tokensOwned": 2
      },
      "transferCount": "1"
    },
    {
      "created": "2021-11-17 17:15:50",
      "id": "2722775",
      "owner": {
        "id": "0x76d6cf3bb66aae4d852efa8c532ec5332757cc9a",
        "tokensOwned": 3,
        "ens": "🍀🍀🍀🍀🍀🍀.eth"
      },
      "transferCount": "1"
    },
    {
      "created": "2021-11-16 21:17:35",
      "id": "2711258",
      "owner": {
        "id": "0x94f99a00c763975c84cc6e3544417330c5e81252",
        "tokensOwned": 4
      },
      "transferCount": "1"
    },
    {
      "created": "2021-11-10 18:16:50",
      "id": "2620791",
      "owner": {
        "id": "0x365e756a137258b2693b61c426f44aa23ddc84e0",
        "tokensOwned": 1
      },
      "transferCount": "1"
    },
    {
      "created": "2021-08-31 15:00:50",
      "id": "964932",
      "owner": {
        "id": "0xa03d1648be58e6957c81c1c201236e189b6ee6af",
        "tokensOwned": 10
      },
      "transferCount": "1"
    },
    {
      "created": "2021-08-23 16:59:25",
      "id": "845378",
      "owner": {
        "id": "0x0d4ddea3849c54e16c85cb4354943dc876e05552",
        "tokensOwned": 25,
        "ens": "palmie.eth"
      },
      "transferCount": "1"
    },
    {
      "migrated": "2021-08-05 23:52:33",
      "id": "80972",
      "owner": {
        "id": "0xd3b325b9c7aa33c8e19f33bbcd6b2fbe3ac66fa7",
        "tokensOwned": 1
      },
      "transferCount": "1"
    },
    {
      "migrated": "2021-07-05 00:19:25",
      "id": "81165",
      "owner": {
        "id": "0x63c9a867d704df159bbbb88eeee1609196b1995e",
        "tokensOwned": 19,
        "ens": "atila.eth"
      },
      "transferCount": "1"
    }
  ]
};
