import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/ui/components/input.address.dart';

class InputHelper {
  static showBottomInput(BuildContext context, String hint,
      TextEditingController controller, Function() onEditingComplete) {
    Get.dialog(
      Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: BottomInputBar(
                    controller: controller,
                    onEditingComplete: onEditingComplete,
                    hint: hint,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      useSafeArea: false,
    );
  }
}
