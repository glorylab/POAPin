import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/event/controller.dart';
import 'package:poapin/ui/pages/event/views/detail.dart';

class BaseInfoView extends StatelessWidget {
  const BaseInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PColor.background,
      padding:
          EdgeInsets.only(top: 256 - 56 + MediaQuery.of(context).padding.top),
      child: CustomScrollView(slivers: [
        DetailView(
          controller: Get.find<EventDetailController>(),
          contentWidth: MediaQuery.of(context).size.width,
          isHorizontal: false,
          context: context,
        )
      ]),
    );
  }
}
