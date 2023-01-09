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
                  builder: (c) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: c.isEditMode
                        ? Container(
                            key: const ValueKey<int>(0),
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [
                                0.3,
                                0.6,
                                0.8,
                              ],
                              colors: [
                                Color(0xFFe43a15),
                                Color(0xFFe65245),
                                Colors.indigo,
                              ],
                            )),
                          )
                        : c.isExpanded
                            ? Container(
                                key: const ValueKey<int>(1),
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  stops: [
                                    0.3,
                                    0.6,
                                    0.8,
                                  ],
                                  colors: [
                                    Color.fromARGB(255, 82, 49, 136),
                                    Color(0xFF403CB5),
                                    Color(0xFF273583),
                                  ],
                                )),
                              )
                            : Container(
                                key: const ValueKey<int>(2),
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  stops: [
                                    0.3,
                                    0.6,
                                    0.8,
                                  ],
                                  colors: [
                                    Color(0xFF965DE9),
                                    Color(0xFF6358EE),
                                    Colors.indigo,
                                  ],
                                )),
                              ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: GetBuilder<HomeController>(
                  builder: (c) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: c.isEditMode
                        ? Text(
                            strEditMode,
                            key: const ValueKey<int>(0),
                            style: GoogleFonts.carterOne(
                              color: Colors.white70,
                              fontSize: 24,
                            ),
                          )
                        : c.isExpanded
                            ? Text(
                                'EXPLORE',
                                key: const ValueKey<int>(1),
                                style: GoogleFonts.carterOne(
                                  color: Colors.white70,
                                  fontSize: 24,
                                ),
                              )
                            : Text(
                                strEnjoy,
                                key: const ValueKey<int>(2),
                                style: GoogleFonts.carterOne(
                                  color: Colors.white70,
                                  fontSize: 24,
                                ),
                              ),
                  ),
                  // Text(
                  //   c.isEditMode ? strEditMode : strEnjoy,
                  //   style: GoogleFonts.carterOne(
                  //     color: Colors.white70,
                  //     fontSize: 24,
                  //   ),
                  // ),
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
