import 'package:ens_dart/ens_dart.dart';
import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:get/get.dart';
import 'package:poapin/data/repository/poap_social_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/home/components/dialog.followers.dart';
import 'package:poapin/ui/pages/home/components/dialog.followings.dart';
import 'package:poapin/util/verification.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';

class SocialCardController extends BaseController {
  List<Map<String, String>> followersWithENS = [];
  List<Map<String, String>> followingsWithENS = [];
  bool isLoadingFollowers = true;
  bool isLoadingFollowings = true;
  bool isError = false;

  final poapSocialRepository = getIt.get<POAPSocialRepository>();

  @override
  onInit() {
    super.onInit();
    final client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });
    ens = Ens(client: client);
  }

  getFollowers(String address) {
    isLoadingFollowers = true;
    followersWithENS = [];
    update();
    poapSocialRepository.getFollowers(address).then(
      (List<String> response) async {
        if (response.isNotEmpty) {
          followersWithENS = initListWithENS(response);
        } else {
          followersWithENS = [];
        }
        isLoadingFollowers = false;
        update();
        refreshENS(followersWithENS);
      },
    );
  }

  getFollowings(String address) {
    isLoadingFollowings = true;
    followingsWithENS = [];
    update();
    poapSocialRepository.getFollowings(address).then(
      (List<String> response) async {
        if (response.isNotEmpty) {
          followingsWithENS = initListWithENS(response);
        } else {
          followingsWithENS = [];
        }
        isLoadingFollowings = false;
        update();
        refreshENS(followingsWithENS);
      },
    );
  }

  List<Map<String, String>> initListWithENS(List<String> ethList) {
    return ethList.map((e) => {checksumEthereumAddress(e): '-'}).toList();
  }

  Future<List<Map<String, String>>> refreshENS(
      List<Map<String, String>> addresses) async {
    List<Map<String, String>> listWithENS = [];
    for (var address in addresses) {
      print(address);
      try {
        await VerificationHelper.getENSbyETH(ens, address.keys.first)
            .then((ensName) {
          address.update(address.keys.first, (value) => ensName);
        });
      } catch (e) {
        address.update(address.keys.first, (value) => '');
      }
    }
    update();
    return listWithENS;
  }

  String getSimpleAddress(String address) {
    if (address.contains('eth')) {
      return address;
    }
    if (address.length > 18) {
      return checksumEthereumAddress(address).substring(0, 10) +
          '...' +
          address.substring(address.length - 4);
    }
    return address;
  }

  void showFollowersDialog() {
    Get.dialog(FollowersDialog(
      followers: followersWithENS,
    ));
  }

  void showFollowingsDialog() {
    Get.dialog(FollowingsDialog(
      followings: followingsWithENS,
    ));
  }

  void launchPOAP() {
    launchURL('https://poap.xyz/');
  }

  @override
  String screenName() {
    return 'SocialCard';
  }
}
