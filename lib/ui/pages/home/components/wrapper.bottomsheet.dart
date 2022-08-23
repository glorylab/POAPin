import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetWrapper extends StatelessWidget {
  final Widget content;

  const BottomSheetWrapper({Key? key, required this.content}) : super(key: key);

  double getHorizontalPadding(context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 512) {
      return (width - 512) / 2;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      mouseCursor: SystemMouseCursors.basic,
      onPressed: () {
        Get.back();
      },
      child: AnimatedPadding(
        curve: Curves.linear,
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.only(
            top: 128 < MediaQuery.of(context).size.height * 0.1
                ? 128
                : MediaQuery.of(context).size.height * 0.1,
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: getHorizontalPadding(context),
            right: getHorizontalPadding(context)),
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {},
            child: Material(
              color: Colors.white,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48)),
              ),
              clipBehavior: Clip.antiAlias,
              elevation: 16,
              child: SafeArea(
                top: false,
                child: content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
