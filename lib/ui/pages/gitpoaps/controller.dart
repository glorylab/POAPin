import 'package:get/get.dart';
import 'package:poapin/data/models/gitpoap.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/util/verification.dart';

class GitPoapsController extends BaseController {
  int momentCount = 0;
  bool isError = false;
  List<GitPoap> gitPOAPs = [];

  Map<String, List<GitPoap>> gitPOAPsByOrganization = {};
  List<Map<String, List<GitPoap>>> gitPOAPsByOrganizationList = [];

  String address = '';

  int offset = 0;
  int limit = 20;
  String sort = 'desc';
  bool isAllDataLoaded = false;

  bool isExpanded = true;

  String getENSorETH(String address) {
    if (address.isNotEmpty) {
      if (VerificationHelper.isENS(address)) {
        return address;
      } else {
        return getSimpleAddress(address);
      }
    } else {
      return '-';
    }
  }

  String getSimpleAddress(String address) {
    if (address.length > 18) {
      return '${address.substring(0, 10)}...${address.substring(address.length - 4)}';
    }
    return address;
  }

  /// Grouping GitPOAP by Organization
  void _getGitPOAPsByOrganization() {
    Map<String, List<GitPoap>> gitPOAPsByOrganization = {};
    for (var gitPOAP in gitPOAPs) {
      String org = 'GitPOAP';
      if (gitPOAP.repositories.isNotEmpty) {
        org = gitPOAP.repositories[0].split('/')[0];
      }
      if (gitPOAPsByOrganization.containsKey(org)) {
        gitPOAPsByOrganization[org]!.add(gitPOAP);
      } else {
        gitPOAPsByOrganization[org] = [gitPOAP];
      }
    }

    gitPOAPsByOrganization.forEach((key, value) {
      gitPOAPsByOrganizationList.add({key: value});
    });
  }

  _getData() {
    final arguments = Get.arguments;
    if (arguments != null && arguments['gitpoaps'] != null) {
      gitPOAPs = arguments['gitpoaps'] as List<GitPoap>;
      address = arguments['address'] as String;

      _getGitPOAPsByOrganization();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _getData();
  }

  @override
  String screenName() {
    return 'GitPOAPs';
  }

  launchGitHubOrg(String org) {
    launchURL('github.com', org);
  }

  toggleIsExpanded() {
    isExpanded = !isExpanded;
    update();
  }

  jumpToPOAP(GitPoap gitPOAP) {
    Get.toNamed(
      '/poap/${gitPOAP.poapTokenID}',
    );
  }
}
