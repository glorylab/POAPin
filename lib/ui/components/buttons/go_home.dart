import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoHomeButton extends StatelessWidget {
  const GoHomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        Get.offAndToNamed('/dashboard');
      },
      focusColor: const Color(0x10001AFF),
      hoverColor: const Color(0x88F2F2F2),
      highlightColor: const Color(0x22001AFF),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.hardEdge,
          children: [
            Image.asset('assets/common/logo_bottom.png'),
            Image.asset('assets/common/logo_top.png'),
          ],
        ),
      ),
    );
  }
}
