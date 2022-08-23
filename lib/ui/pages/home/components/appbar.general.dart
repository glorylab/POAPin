import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/pages/home/components/button.edit_done.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class GeneralAPPBar extends StatelessWidget implements PreferredSizeWidget {
  const GeneralAPPBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: GetBuilder<HomeController>(
                  builder: (c) => Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: const [
                        0.3,
                        0.6,
                        0.8,
                      ],
                      colors: !c.isEditMode
                          ? [
                              const Color(0xFF965DE9),
                              const Color(0xFF6358EE),
                              Colors.indigo,
                            ]
                          : [
                              const Color(0xFFe43a15),
                              const Color(0xFFe65245),
                              Colors.indigo,
                            ],
                    )),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: GetBuilder<HomeController>(
                  builder: (c) => Text(
                    c.isEditMode ? strEditMode : strEnjoy,
                    style: GoogleFonts.carterOne(
                      color: Colors.white70,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: const [
        EditDoneButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
