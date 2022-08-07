import 'package:flutter/material.dart';
import 'package:poapin/res/colors.dart';

class Box extends StatelessWidget {
  final Widget? logo;
  final Widget page;

  const Box({Key? key, required this.page, this.logo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
