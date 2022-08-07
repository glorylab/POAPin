import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkResponse(
        onTap: () {
          Get.back();
        },
        child: SizedBox(
          width: 56,
          height: 56,
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.hardEdge,
            children: [
              Image.asset('assets/common/logo_back.png'),
            ],
          ),
        ),
      ),
    );
  }
}
