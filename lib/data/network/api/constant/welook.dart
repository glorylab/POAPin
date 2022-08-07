class WelookConstant {
  WelookConstant._();

  static const String welookUrl = "https://welook.tech/api/v1";

  /// ------------------------------------------------------------
  /// Endpoints
  /// ------------------------------------------------------------

  /// Check if there are available Welook moments for
  /// a certain POAP and the exact amount.
  static String momentCount(int eventID) => '/moments/total/$eventID';
}
