import 'package:poapin/secrets.dart';

class WelookConstant {
  WelookConstant._();

  static const String welookUrl = "https://welook.tech/api/v2";

  static const String welookAPIKey = Secrets.welookAPIKEY;

  /// ------------------------------------------------------------
  /// Endpoints
  /// ------------------------------------------------------------

  /// Check if there are available Welook moments for
  /// a certain POAP and the exact amount.
  static String momentCount(int eventID) => '/moments/$eventID/total';
}
