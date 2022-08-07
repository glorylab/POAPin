import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFilterController extends GetxController {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final FocusScopeNode focusNode = FocusScopeNode();

  @override
  void onInit() {
    nameController.text = '';
    descController.text = '';
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    descController.dispose();
    super.onClose();
  }

  clear() {
    nameController.text = '';
    descController.text = '';
  }
}
