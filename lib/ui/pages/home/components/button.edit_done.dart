import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class EditDoneButton extends StatelessWidget {
  const EditDoneButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => c.isEditMode
          ? RawMaterialButton(
              onPressed: () {
                c.clearSelectedTokens();
                c.setIsEditMode(false);
              },
              child: Row(
                children: [
                  Text(
                    strDone,
                    style: GoogleFonts.epilogue(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ))
          : Container(),
    );
  }
}
