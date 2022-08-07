import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class DashboardController extends BaseController {
  late TapGestureRecognizer onTapRecognizer;
  bool isNoticeRead = false;

  @override
  void onInit() {
    onTapRecognizer = TapGestureRecognizer()..onTap = _handlePress;
    _init();
    super.onInit();
  }

  @override
  void onClose() {
    onTapRecognizer.dispose();
    super.onClose();
  }

  void _handlePress() {
    HapticFeedback.vibrate();
  }

  @override
  String screenName() {
    return 'Dashboard';
  }

  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    if (index == 0) {
      Get.find<HomeController>().getData();
    }
  }

  void _checkIsNoticeRead() {
    Box box = Hive.box(prefBox);
    isNoticeRead = box.get(prefHeaderNoticeReadKey, defaultValue: false);
    update();
  }

  Future<void> _init() async {
    _checkIsNoticeRead();
  }

  void markAsRead() {
    Hive.box(prefBox).put(prefHeaderNoticeReadKey, true);
    _checkIsNoticeRead();
  }
}
