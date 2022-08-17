import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:poapin/ui/pages/me/controller.dart';
import 'package:poapin/util/verification.dart';

class ProfileController extends BaseController {
  final addressController = TextEditingController();
  final address = ''.obs;
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  String screenName() {
    return 'Profile';
  }

  Future<void> _init() async {}

  Future backToHome() async {
    Get.back();
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      if (Get.previousRoute == '/profile') {
        Get.back();
      } else if (Get.previousRoute == '') {
        Get.offAndToNamed('/dashboard');
      } else {
        Get.until((route) => Get.currentRoute == '/dashboard');
      }
    });
  }

  void showError() {
    Get.back();
    Get.snackbar(
        'Error', 'There was a problem deleting the account, please try again.',
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

  Future<bool> deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
    } catch (e) {
      return false;
    }
    return true;
  }

  String getSimpleAddress(String address) {
    if (address.length > 18) {
      return address.substring(0, 10) +
          '...' +
          address.substring(address.length - 4);
    }
    return address;
  }

  void onSubmit() async {
    Get.back();
    if (addressController.text.isNotEmpty &&
            VerificationHelper.isETH(addressController.text.trim()) ||
        VerificationHelper.isENS(addressController.text.trim())) {
      String _address = addressController.text.trim().toLowerCase();

      if (_address != ethAddress && _address != ensAddress) {
        await FirebaseAuth.instance.signOut();
        update();
      }
      await saveAccount(_address);
      addressController.clear();

      getAccount();
      Get.find<HomeController>().onInit();
      Get.find<MeController>().onInit();
    } else {
      Get.snackbar('Error', 'Invalid address',
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
}
