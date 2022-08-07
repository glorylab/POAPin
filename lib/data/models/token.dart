import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:poapin/data/models/tag.dart';

part 'token.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class Token {
  @HiveField(0)
  final String tokenId;
  @HiveField(1)
  final String owner;
  @HiveField(2)
  final String? created;
  @HiveField(3)
  final String? layer;
  @HiveField(4)
  final Event event;
  @JsonKey(
    name: 'supply',
    fromJson: _handleSupply,
  )
  @HiveField(5)
  final Supply? supply;
  @HiveField(6)
  final String? chain;

  Token(
    this.event,
    this.tokenId,
    this.owner,
    this.created,
    this.layer,
    this.supply,
    this.chain,
  );

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  static Supply? _handleSupply(s) => s == null ? null : Supply.fromJson(s);

  factory Token.empty() {
    return Token(
      Event.empty(),
      '',
      '',
      '',
      '',
      null,
      '',
    );
  }
}

@JsonSerializable()
@HiveType(typeId: 7)
class Event {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;

  @JsonKey(name: 'fancy_id')
  @HiveField(2)
  final String fancyID;

  @JsonKey(name: 'image_url')
  @HiveField(3)
  final String imageUrl;

  @JsonKey(
    name: 'start_date',
    fromJson: _timeConverter,
  )
  @HiveField(4)
  final DateTime? startDate;

  @JsonKey(
    name: 'expiry_date',
    fromJson: _timeConverter,
  )
  @HiveField(5)
  final DateTime? expiryDate;

  @HiveField(6)
  final int id;

  @HiveField(7)
  final int year;

  @JsonKey(
    name: 'realYear',
    fromJson: _defaultInt,
  )
  @HiveField(8)
  int realYear;

  @JsonKey(
    name: 'month',
    fromJson: _defaultInt,
  )
  @HiveField(9)
  int month;

  @JsonKey(
    name: 'day',
    fromJson: _defaultInt,
  )
  @HiveField(10)
  int day;

  @HiveField(11)
  final int? supply;

  @HiveField(12)
  final String? country;

  @HiveField(13)
  final String? city;

  @JsonKey(name: 'event_url')
  @HiveField(14)
  final String? eventUrl;

  @JsonKey(
    name: 'end_date',
    fromJson: _timeConverter,
  )
  @HiveField(15)
  final DateTime? endDate;

  @JsonKey(name: 'signer_ip')
  @HiveField(16)
  final String? signerIP;

  @JsonKey(name: 'signer')
  @HiveField(17)
  final String? signer;

  @JsonKey(
    name: 'tags',
    fromJson: _defaultTag,
  )
  @HiveField(18)
  List<Tag>? tags;

  Event(
    this.fancyID,
    this.name,
    this.imageUrl,
    this.description,
    this.startDate,
    this.expiryDate,
    this.id,
    this.year,
    this.realYear,
    this.month,
    this.day,
    this.supply,
    this.eventUrl,
    this.country,
    this.city,
    this.endDate,
    this.signerIP,
    this.signer,
    this.tags,
  );

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$EventToJson(this);

  static DateTime? _timeConverter(t) {
    if (t == null) return null;
    return Jiffy(t, "dd-MMM-yyyy").dateTime;
    // return Jiffy(Jiffy(t, "dd-MMM-yyyy").dateTime).yMMMd;
  }

  static int _defaultInt(t) {
    if (t == null) return 0;
    return 0;
  }

  static List<Tag> _defaultTag(t) {
    return [];
  }

  factory Event.empty() {
    return Event('', '', '', '', null, null, 0, 0, 0, 0, 0, null, null, null,
        null, null, null, null, null);
  }
}

@JsonSerializable()
@HiveType(typeId: 8)
class Supply {
  @HiveField(0)
  final int? total;
  @HiveField(1)
  final int? order;

  Supply(this.total, this.order);

  factory Supply.fromJson(Map<String, dynamic> json) => _$SupplyFromJson(json);

  Map<String, dynamic> toJson() => _$SupplyToJson(this);
}

var example = {
  "event": {
    "id": 23847,
    "fancy_id": "metaverse-amazing-new-age-genesis-2022",
    "name": "Metaverse Amazing New Age: Genesis",
    "event_url": "https://mana.xyz",
    "image_url":
        "https://assets.poap.xyz/metaverse-amazing-new-age-genesis-2022-logo-1642695189227.png",
    "country": "",
    "city": "Metaverse",
    "description":
        "We are most grateful to the early users who participated in the beta test of mana.xyz.\r\n\r\nmana.xyz is currently a short domain service for Decentraland, you can access any land directly by entering the coordinates after the domain, for example: mana.xyz/12,34. And more convenient features will be developed in the near future.\r\n\r\nTo celebrate the launch of Glory Lab's first product, starting January 23, 2022, users who access Decentraland from mana.xyz can contact @glorylaboratory to receive this commemorative POAP.\r\n\r\nWAGMI",
    "year": 2022,
    "start_date": "23-Jan-2022",
    "end_date": "23-Feb-2022",
    "expiry_date": "23-Mar-2022",
    "supply": 237,
    "signer_ip": "string",
    "signer": "string",
  },
  "tokenId": "3618141",
  "owner": "0x0575d9F00FCeDc434B0E263e98789994CDA3Cb53",
  "created": "2022-01-20 16:36:40",
  "layer": "string",
  "supply": {
    "total": 237,
    "order": 0,
  }
};
