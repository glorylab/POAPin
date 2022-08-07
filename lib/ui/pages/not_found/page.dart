import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/components/alerts/alert.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/not_found/controller.dart';

class NotFoundPage extends BasePage<NotFoundController> {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    return Material(
      color: const Color(0xFF6534FF),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: AlertBoard(
                image: 'assets/common/404.png',
                text: 'You\'re on the wrong page, it\'s okay.',
                textColor: Colors.white54,
                button: RawMaterialButton(
                  fillColor: Colors.white,
                  elevation: 0.0,
                  hoverElevation: 16.0,
                  focusElevation: 12.0,
                  highlightElevation: 12.0,
                  onPressed: () {
                    Get.toNamed("/dashboard");
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Go Home',
                      style: GoogleFonts.carterOne(
                        color: const Color(0xFF6534FF),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
