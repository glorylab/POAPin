import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/ui/components/box.dart';
import 'package:poapin/ui/pages/home/controller.dart';

abstract class BaseTransparentPage<T> extends GetView<T> {
  const BaseTransparentPage({Key? key}) : super(key: key);

  Widget getPage(BuildContext context);

  Widget getLead();

  double getHorizontalPadding(context) {
    double width = MediaQuery.of(context).size.width;
    if (Get.find<HomeController>().isWebOption) {
      return 16;
    }
    if (width > 768) {
      return (width - 768) / 2;
    } else {
      return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Box(
      page: getPage(context),
      logo: getLead(),
      isTransparent: true,
    );
  }
}
