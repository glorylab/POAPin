import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final expanded = false.obs;

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

  expand() {
    expanded.value = true;
  }

  close() {
    expanded.value = false;
  }
}
