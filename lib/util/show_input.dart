import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/components/input.account.dart';
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

  static showAccountInput(BuildContext context, String hint,
      TextEditingController controller, Function() onEditingComplete) {
    return Get.dialog(
      Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white, PColor.background],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: AccountInputPage(
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
      transitionDuration: const Duration(milliseconds: 120),
      transitionCurve: Curves.easeInExpo,
    ).then((value) => value);
  }
}
