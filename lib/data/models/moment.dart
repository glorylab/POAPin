import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'moment.g.dart';

@JsonSerializable()
@HiveType(typeId: 16)
class Moment extends HiveObject {
  @JsonKey(name: 'id')
  @HiveField(0)
  final String momentId;

  @JsonKey(name: 'likes')
  @HiveField(1)
  final int likesCount;

  @JsonKey(name: 'address')
  @HiveField(2)
  final String authorAddress;

  @JsonKey(name: 'ens')
  @HiveField(3)
  final String? authorENS;

  @HiveField(4)
  final String publishDate;

  @HiveField(5)
  final String? description;

  @JsonKey(name: 'poapId')
  @HiveField(6)
  final String poapEventID;

  @JsonKey(name: '1000x1000')
  @HiveField(7)
  final String bigImageUrl;

  @JsonKey(name: '250x250')
  @HiveField(8)
  final String? smallImageUrl;

  @JsonKey(name: 'originalUrl')
  @HiveField(9)
  final String? originImageUrl;

  @JsonKey(name: 'likesA')
  @HiveField(10)
  final List<String>? likesAddressList;

  Moment({
    required this.momentId,
    required this.likesCount,
    required this.authorAddress,
    required this.authorENS,
    required this.publishDate,
    required this.description,
    required this.poapEventID,
    required this.bigImageUrl,
    required this.smallImageUrl,
    required this.originImageUrl,
    required this.likesAddressList,
  });

  factory Moment.fromJson(Map<String, dynamic> json) => _$MomentFromJson(json);

  Map<String, dynamic> toJson() => _$MomentToJson(this);

  factory Moment.empty() => Moment(
        momentId: '',
        likesCount: 0,
        authorAddress: '',
        authorENS: '',
        publishDate: '',
        description: '',
        poapEventID: '',
        bigImageUrl: '',
        smallImageUrl: '',
        originImageUrl: '',
        likesAddressList: [],
      );
}

@JsonSerializable()
class MomentResponse {
  final int status;

  @JsonKey(name: 'offsetN')
  final int? offset;

  final int? total;

  @JsonKey(name: 'photos')
  final List<Moment>? moments;

  MomentResponse(this.status, this.offset, this.total, this.moments);

  factory MomentResponse.fromJson(Map<String, dynamic> json) =>
      _$MomentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MomentResponseToJson(this);
}

var example = {
  "id": "001d0e31-8a08-4b0c-ae33-23069fb1f8fe",
  "likes": 1,
  "address": "0x0769cBf44073741cCb4C39c945402130B46fa8A7",
  "publishDate": "2022-05-23T00:13:48+00:00",
  "description": "",
  "poapId": "44608", //eventID
  "1000x1000": "",
  "250x250": "",
  "originalUrl":
      "https://firebasestorage.googleapis.com/v0/b/welook-siwe.appspot.com/o/moments%2F44608%2F001d0e31-8a08-4b0c-ae33-23069fb1f8fe?alt=media&token=001d0e31-8a08-4b0c-ae33-23069fb1f8fe",
  "likesA": [
    "0x0769cBf44073741cCb4C39c945402130B46fa8A7",
  ]
};
