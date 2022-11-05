import 'package:poapin/secrets.dart';

class POAPINConstant {
  POAPINConstant._();

  static const String baseUrl = "https://api.poap.in";

  static const String poapinAPIKey = Secrets.poapinAPIKEY;

  /// ------------------------------------------------------------
  /// Endpoints
  /// ------------------------------------------------------------

  static const String gm = '/user/gm';
  static const String gmgm = '/gm/gm';
}
