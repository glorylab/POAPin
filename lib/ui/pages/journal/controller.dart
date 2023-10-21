import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/ui/controller.base.dart';

class JournalController extends BaseController {
  ScrollController scrollController = ScrollController();

  /// Island
  bool isExpanded = false;
  bool isIslandInit = true;
  bool isIslandLive = false;
  bool isSticky = false;

  final addressController = TextEditingController();

  void onAddressSubmit() async {
    Get.back();
  }

  setIsIslandLive(bool isLive) {
    isIslandLive = isLive;
    update();
  }

  setIslandExpanded(bool isExpanded) {
    this.isExpanded = isExpanded;
    isIslandInit = false;
    update();
  }

  setIslandSticky(bool isSticky) {
    this.isSticky = isSticky;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    isExpanded = false;
    isIslandInit = true;
  }

  @override
  String screenName() {
    return 'Journal';
  }
}
