import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:poapin/ui/pages/home/controllers/island.dart';
import 'package:poapin/ui/pages/me/controller.dart';
import 'package:poapin/util/show_input.dart';

class SetETHAddressButton extends StatelessWidget {
  const SetETHAddressButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => RawMaterialButton(
        elevation: 1,
        highlightColor: Theme.of(context).primaryColorLight,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Color(0x116534FF), width: 4),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        fillColor: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              width: 12,
            ),
            const Icon(Icons.auto_awesome),
            const SizedBox(
              width: 16,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                strSetEthAddress,
                maxLines: 1,
                style: GoogleFonts.courierPrime(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        onPressed: () async {
          Get.put(ExploreIslandController());
          InputHelper.showAccountInput(
            context,
            'poap.eth / 0x00...',
            c.addressController,
            c.onAddressSubmit,
          ).then((value) {
            if (value == 'close') {
              c.setIslandExpanded(false);
            }
          });
        },
      ),
    );
  }
}
