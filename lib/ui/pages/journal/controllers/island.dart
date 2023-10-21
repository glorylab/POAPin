import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/journal/controller.dart';
import 'package:poapin/ui/pages/me/controller.dart';
import 'package:poapin/util/verification.dart';

enum AddressType { ethereum, ens, email, invalid, none }

class IslandController extends BaseController {
  bool canPaste = true;
  bool isVerifying = false;

  String address = '';
  AddressType addressType = AddressType.none;

  final TextEditingController textEditController = TextEditingController();

  void paste() {
    if (canPaste) {
      Clipboard.getData(Clipboard.kTextPlain).then((value) {
        if (value != null && value.text != null) {
          textEditController.text = (value.text)!;
        }
      });
    }
  }

  void verify() {
    isVerifying = true;
    update();
    if (VerificationHelper.isETH(address)) {
      isVerifying = false;
      addressType = AddressType.ethereum;
      update();
    } else if (VerificationHelper.isENS(address)) {
      isVerifying = false;
      addressType = AddressType.ens;
      update();
    } else if (VerificationHelper.isEmail(address)) {
      isVerifying = false;
      addressType = AddressType.email;
      update();
    } else {
      isVerifying = false;
      addressType = AddressType.invalid;
      update();
    }
  }

  void onSubmit() async {
    if (textEditController.text.isNotEmpty &&
        VerificationHelper.isETH(textEditController.text.trim()) ||
        VerificationHelper.isENS(textEditController.text.trim())) {
      String address = textEditController.text.trim().toLowerCase();

      await saveAccount(address);
      textEditController.clear();

      getAccount();
      Get.find<JournalController>().onInit();
      Get.find<MeController>().onInit();
      Get.back(result: 'close');
    }
  }

  @override
  void onInit() {
    super.onInit();
    textEditController.addListener(() {
      if (textEditController.text.isNotEmpty) {
        canPaste = false;
        address = textEditController.text;
      } else {
        canPaste = true;
      }
      update();
      verify();
    });
  }

  @override
  void onClose() {
    textEditController.dispose();
    super.onClose();
  }

  @override
  String screenName() {
    return 'Island';
  }
}
