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

  /// Fetch the moments for a certain event.
  static String getMementsOfEvent(
    int eventID, {
    int limit = 20,
    int offset = 0,
    String sort = 'asc',
  }) =>
      '/moments?eventId=$eventID&limit=$limit&offset=$offset&sort=$sort';

  /// Fetch the moments for a certain address.
  static String getMomentsOfAddress(
    String address, {
    int limit = 20,
    int offset = 0,
    String sort = 'asc',
  }) =>
      '/moments?address=$address&limit=$limit&offset=$offset&sort=$sort';

  /// Fetch the moments in a certain event for a certain user.
  static String getMomentsOfAddressInEvent(
    String address,
    int eventID, {
    int limit = 20,
    int offset = 0,
    String sort = 'asc',
  }) =>
      '/moments?address=$address&eventId=$eventID&limit=$limit&offset=$offset&sort=$sort';

  /// Fetch a moment.
  static String getMoment(
    int momentID, {
    int limit = 20,
    int offset = 0,
    String sort = 'asc',
  }) =>
      '/moments?momentId=$momentID&limit=$limit&offset=$offset&sort=$sort';
}
