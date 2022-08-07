class GitPOAPConstant {
  GitPOAPConstant._();

  static const String gitPOAPUrl = "https://public-api.gitpoap.io/v1";

  /// ------------------------------------------------------------
  /// Endpoints
  /// ------------------------------------------------------------

  /// This endpoint allows users to query whether some poapTokenId
  /// is a GitPOAP or not. In the case that the poapTokenId corresponds
  /// to some claimed GitPOAP.
  static String isTokenGitPOAP(String tokenID) => '/poap/$tokenID/is-gitpoap';

  /// This endpoint allows users to query whether some poapEventId is
  /// for GitPOAP project contribution level. In the case that
  /// the poapEventId is for a GitPOAP project contribution level.
  static String isEventGitPOAP(int eventID) =>
      '/poap-event/$eventID/is-gitpoap';

  /// This endpoint allows users to query for a list of addresses
  /// that hold a GitPOAP specified by ID.
  static String getHoldersOfGitPOAP(String gitPOAPID) =>
      '/gitpoaps/$gitPOAPID/addresses';

  /// This endpoint allows users to query for a list of
  /// all addresses that hold any GitPOAP.
  static const String getAllHolders = '/gitpoaps/addresses';

  /// This endpoint allows users to query for some address's
  /// (either and ETH or ENS address) GitPOAPs.
  static String scanGitPOAP(String address) => '/address/$address/gitpoaps';
}
