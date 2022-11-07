/// POAP followers backend
/// https://followers.poap.tech/api-doc/
class POAPSocialConstant {
  POAPSocialConstant._();

  static const String poapSocialUrl = "https://followers.poap.tech/v1";

  /// ------------------------------------------------------------
  /// Endpoints
  /// ------------------------------------------------------------

  /// Returns the accounts a specific account follows
  static String followings(String address) => '/accounts/$address/followings';

  /// Returns the accounts that follow the given account
  static String followers(String address) => '/accounts/$address/followers';
}
