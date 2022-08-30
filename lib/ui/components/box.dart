import 'package:flutter/material.dart';
import 'package:poapin/res/colors.dart';

class Box extends StatelessWidget {
  final Widget? logo;
  final Widget page;
  final bool? isTransparent;

  const Box(
      {Key? key, required this.page, this.logo, this.isTransparent = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isTransparent != null && isTransparent == true) {
      return Stack(
        children: [
          page,
          Positioned(
            left: 0,
            top: 0,
            child: SafeArea(
              child: logo ?? Container(),
            ),
          ),
        ],
      );
    }
    return Material(
      color: PColor.background,
      child: Stack(
        children: [
          page,
          Positioned(
            left: 0,
            top: 0,
            child: SafeArea(
              child: logo ?? Container(),
            ),
          ),
        ],
      ),
    );
  }
}
