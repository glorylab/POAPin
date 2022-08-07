import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/components/logo.dart';

class POAPinSliverAPPBar extends StatelessWidget {
  const POAPinSliverAPPBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      primary: false,
      pinned: true,
      floating: false,
      snap: false,
      automaticallyImplyLeading: !GetPlatform.isWeb,
      expandedHeight: 256.0,
      elevation: 0.0,
      backgroundColor: PColor.background,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: const Color(0xFFFF8934),
          child: const POAPinLogo(),
        ),
      ),
    );
  }
}
