import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/components/buttons/back.dart';
import 'package:poapin/ui/components/buttons/go_home.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/app/controller.dart';

class APPPage extends BasePage<APPController> {
  const APPPage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        automaticallyImplyLeading: false,
        leading: Get.previousRoute == ''
            ? const GoHomeButton()
            : const GoBackButton(),
        backgroundColor: Colors.white,
        title: Text(
          'POAP.in - APP download',
          overflow: TextOverflow.fade,
          style: GoogleFonts.carterOne(
            color: const Color(0xFF6534FF),
            shadows: [
              Shadow(
                  color: Colors.white.withOpacity(0.8),
                  offset: const Offset(1, 1),
                  blurRadius: 2),
            ],
          ),
        ),
      ),
      body: Align(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text('Android',
                        style: GoogleFonts.lato(
                          color: Colors.black26,
                          fontSize: 30,
                        )),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 3,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 88,
                            width: 180,
                            child: RawMaterialButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              fillColor: const Color(0xFF01875f),
                              onPressed: () {
                                controller.launchURL(
                                    'https://play.google.com/store/apps/details?id=in.poap');
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Available on',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Google Play',
                                      style: GoogleFonts.roboto(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 3,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 88,
                            width: 180,
                            child: RawMaterialButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              fillColor: const Color(0xFF24cd77),
                              onPressed: () {
                                controller.launchURL(
                                    'https://apkpure.com/poapin/in.poap');
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Get APK on',
                                      style: GoogleFonts.roboto(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'APKPure',
                                      style: GoogleFonts.roboto(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text('iOS',
                        style: GoogleFonts.lato(
                          color: Colors.black26,
                          fontSize: 30,
                        )),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 88,
                      width: 180,
                      child: RawMaterialButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        fillColor: const Color(0xFF2997ff),
                        onPressed: () {
                          controller.launchURL(
                              'https://testflight.apple.com/join/OqNzJ9UJ');
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Join the beta on',
                                style: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'TestFlight',
                                style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
