import 'package:poapin/secrets.dart';

class POAPConstant {
  POAPConstant._();

  static const String poapAPIKey = Secrets.poapAPIKEY;

  static const String poapUrl = "https://api.poap.tech";

  /// ------------------------------------------------------------
  /// Endpoints
  /// ------------------------------------------------------------

  static String scan(String address) => '/actions/scan/$address';
  static String token(String tokenID) => '/token/$tokenID';
  static String holders(int eventID) => '/event/$eventID/poaps';
  static String event(int eventID) => '/events/id/$eventID';
}
