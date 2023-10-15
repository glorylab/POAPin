import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'gitpoap.g.dart';

@JsonSerializable()
@HiveType(typeId: 17)
class GitPoap extends HiveObject {
  @JsonKey(name: 'gitPoapId')
  @HiveField(0)
  final int gitPOAPID;

  @JsonKey(name: 'gitPoapEventId')
  @HiveField(1)
  final int gitPOAPEventID;

  @JsonKey(name: 'poapTokenId')
  @HiveField(2)
  final String poapTokenID;

  @JsonKey(name: 'poapEventId')
  @HiveField(3)
  final int poapEventID;

  @JsonKey(name: 'poapEventFancyId')
  @HiveField(4)
  final String poapEventFancyID;

  @HiveField(5)
  final String name;

  @HiveField(6)
  final int year;

  @HiveField(7)
  final String description;

  @JsonKey(name: 'imageUrl')
  @HiveField(8)
  final String imageURL;

  @HiveField(9)
  final List<String> repositories;

  @HiveField(10)
  final String earnedAt;

  @HiveField(11)
  final String mintedAt;

  GitPoap(
    this.gitPOAPID,
    this.gitPOAPEventID,
    this.poapTokenID,
    this.poapEventID,
    this.poapEventFancyID,
    this.name,
    this.year,
    this.description,
    this.imageURL,
    this.repositories,
    this.earnedAt,
    this.mintedAt,
  );

  factory GitPoap.fromJson(Map<String, dynamic> json) =>
      _$GitPoapFromJson(json);

  Map<String, dynamic> toJson() => _$GitPoapToJson(this);
}

var example = {
  "gitPoapId": 3143,
  "gitPoapEventId": 120,
  "poapTokenId": "4984952",
  "poapEventId": 44883,
  "poapEventFancyId": "gitpoap-2022-project-sunshine-contributor-2022",
  "name": "GitPOAP: 2022 Project Sunshine Contributor",
  "year": 2022,
  "description":
      "You made at least one contribution to the Project Sunshine project in 2022. Your contributions are greatly appreciated!",
  "imageUrl":
      "https://assets.poap.xyz/gitpoap-2022-project-sunshine-contributor-2022-logo-1652814406598.png",
  "repositories": ["etheralpha/project-sunshine"],
  "earnedAt": "2022-04-13",
  "mintedAt": "2022-05-17"
};
