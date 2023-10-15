import 'package:dio/dio.dart';
import 'package:ens_dart/ens_dart.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:poapin/util/verification.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class MeController extends BaseController {
  final turns = 0.0.obs;
  final isRotationStart = false.obs;
  final isRotationEnd = true.obs;

  final addressController = TextEditingController();
  final address = ''.obs;

  final isLoading = false.obs;

  String error = '';
  String link = '';
  String message = '';
  bool isDispensed = false;

  bool isRequesting = false;

  @override
  void onInit() {
    addressController.text = '';
    super.onInit();
    link = account.claimLink ?? '';
    isDispensed = account.isDispensed ?? false;
    update();
    _initEns();
  }

  _initEns() {
    final client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });
    ens = Ens(client: client);

    final parameters = Get.parameters;
    final String address = parameters['address'].toString();
    VerificationHelper.getEthAndEns(ens, address).then((value) {
      List<String> ethAndEns = value;
      String eth = ethAndEns[0];
      String ens = ethAndEns[1];
      if (eth == '' && ens == '') {
        return;
      }
      if (ens.isNotEmpty) {
        ensAddress = ens;
        ethAddress = eth;
        update();
      }
    });
  }

  void onSubmit() async {
    Get.back();
    if (addressController.text.isNotEmpty &&
            VerificationHelper.isETH(addressController.text.trim()) ||
        VerificationHelper.isENS(addressController.text.trim())) {
      isLoading.value = true;

      String address = addressController.text.trim().toLowerCase();

      if (address != ethAddress && address != ensAddress) {
        await FirebaseAuth.instance.signOut();
        update();
      }
      await saveAccount(address);
      isLoading.value = false;
      addressController.clear();

      getAccount();
      Get.find<HomeController>().onInit();
    } else {
      Get.snackbar(strError, strInvalidAddress,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade300,
          animationDuration: const Duration(milliseconds: 200),
          duration: const Duration(seconds: 1),
          colorText: Colors.white,
          borderRadius: 8,
          margin: const EdgeInsets.all(8),
          overlayBlur: 8,
          snackStyle: SnackStyle.FLOATING);
    }
  }

  @override
  void onClose() {
    addressController.dispose();
    super.onClose();
  }

  void changeRotation() {
    isRotationEnd.value = false;
    turns.value += 1.0;
  }

  @override
  String screenName() {
    return 'Me';
  }

  void showDialogOnWeb() {
    Get.defaultDialog(
      radius: 24,
      titlePadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(16),
      title: 'Sorry',
      content: const Text('This POAP can only be picked up in the mobile app.'),
    );
  }

  void showClaimLink(BuildContext context) {
    Get.bottomSheet(Material(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: ExtendedImage.network(
              'https://storageapi.fleek.co/42d9e31b-61dc-47e8-8b96-ad41deb3538f-bucket/poapin/POAP.in launch copy.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: ListView(
              children: [
                const SizedBox(height: 16),
                Material(
                  elevation: 8,
                  shape: const CircleBorder(
                      side: BorderSide(color: Colors.white30, width: 4)),
                  child: ExtendedImage.network(
                    'https://assets.poap.xyz/public-launch-celebration-of-poapin-2022-logo-1644857492906.png',
                    width: 128,
                    height: 128,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Material(
                    color: Colors.white.withOpacity(0.92),
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white30, width: 4),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Text(
                        link,
                        style: GoogleFonts.courierPrime(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      fillColor: Colors.white12,
                      elevation: 0,
                      focusElevation: 0,
                      hoverElevation: 0,
                      highlightElevation: 0,
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: link));
                        Get.snackbar(
                            'Copied!', 'Please don\'t forget to claim.');
                      },
                      child: Text(
                        'copy',
                        style: GoogleFonts.courierPrime(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    RawMaterialButton(
                      fillColor: Colors.white12,
                      elevation: 0,
                      focusElevation: 0,
                      hoverElevation: 0,
                      highlightElevation: 0,
                      onPressed: () {
                        launchDynamicURL(link);
                      },
                      child: Text(
                        'visit',
                        style: GoogleFonts.courierPrime(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Thank you, early supporters! Let\'s make this world a better place with POAP!',
                      style: GoogleFonts.courierPrime(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  String getSimpleAddress(String address) {
    if (address.length > 18) {
      return '${address.substring(0, 10)}...${address.substring(address.length - 4)}';
    }
    return address;
  }

  void getData(BuildContext context) async {
    if (ethAddress == '') {
      Get.defaultDialog(
        radius: 24,
        titlePadding: const EdgeInsets.all(16),
        contentPadding: const EdgeInsets.all(16),
        title: 'No account',
        content: const Text('Please set your ETH address first :)'),
      );
      return;
    }
    isRequesting = true;
    update();
    try {
      var response =
          await Dio().get('https://api.poap.in/poap?address=$ethAddress');
      isRequesting = false;
      update();
      error = '';
      var data = response.data;
      if (data['code'] != null && data['code'] < 0) {
        error = data['message'] ?? 'Unknown error';
        Get.defaultDialog(
          radius: 24,
          titlePadding: const EdgeInsets.all(16),
          contentPadding: const EdgeInsets.all(16),
          title: 'Oops',
          content: Text(error),
        );
      } else if (data['code'] != null && data['code'] == 0) {
        error = '';
        isDispensed = true;
        link = data['data'];
        update();
        setIsDispensed(link);
        showClaimLink(context);
      }
    } on DioException catch (e) {
      Get.defaultDialog(
        radius: 24,
        titlePadding: const EdgeInsets.all(16),
        contentPadding: const EdgeInsets.all(16),
        title: strError,
        content: Text(e.message??"Unknown"),
      );
    }
  }
}
