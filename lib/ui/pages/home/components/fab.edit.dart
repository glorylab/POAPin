import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class EditFAB extends StatelessWidget {
  const EditFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => c.isEditMode && c.selectedTokens.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                c.editTag();
              },
              label: Text(strEditTags))
          : Container(),
    );
  }
}
