import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'event_poap.g.dart';

@JsonSerializable()
@HiveType(typeId: 14)
class EventPOAPResponse extends HiveObject {
  @HiveField(0)
  final int limit;
  @HiveField(1)
  final int offset;
  @HiveField(2)
  final int total;
  @HiveField(3)
  final List<EventPOAP> tokens;

  EventPOAPResponse({
    required this.limit,
    required this.offset,
    required this.total,
    required this.tokens,
  });

  factory EventPOAPResponse.fromJson(Map<String, dynamic> json) =>
      _$EventPOAPResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventPOAPResponseToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 13)
class EventPOAP extends HiveObject {
  @HiveField(0)
  final String created;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String transferCount;
  @HiveField(3)
  final EventPOAPOwner owner;

  EventPOAP({
    required this.created,
    required this.id,
    required this.transferCount,
    required this.owner,
  });

  factory EventPOAP.fromJson(Map<String, dynamic> json) =>
      _$EventPOAPFromJson(json);

  Map<String, dynamic> toJson() => _$EventPOAPToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 12)
class EventPOAPOwner extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int tokensOwned;
  @HiveField(2)
  final String ens;

  EventPOAPOwner({
    required this.id,
    required this.tokensOwned,
    required this.ens,
  });

  factory EventPOAPOwner.fromJson(Map<String, dynamic> json) =>
      _$EventPOAPOwnerFromJson(json);

  Map<String, dynamic> toJson() => _$EventPOAPOwnerToJson(this);
}

var example = {
  "limit": 1,
  "offset": 0,
  "total": 401,
  "tokens": [
    {
      "created": "2022-07-23 04:21:50",
      "id": "5393690",
      "owner": {
        "id": "0xe43cccff830abb7d48727bfc49f7cab19a465023",
        "tokensOwned": 1,
        "ens": "wuge18.eth"
      },
      "transferCount": "0"
    }
  ]
};
