import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/controllers/controller.user.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/home/controllers/card.moment.dart';

class MomentDialog extends StatelessWidget {
  const MomentDialog({Key? key}) : super(key: key);

  Widget _buildMomentsDesc() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 72),
          Text(
            strMomentsDesc,
            style: GoogleFonts.roboto(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(left: 32, right: 32, bottom: 44, top: 32),
        child: Material(
          color: Colors.white,
          shadowColor: Colors.black54,
          elevation: 8,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(56)),
            side: BorderSide(color: Color(0xFFD2D2D2), width: 4),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            constraints: const BoxConstraints(
                maxWidth: 600, minWidth: 320, minHeight: 128, maxHeight: 512),
            child: Stack(
              children: [
                _buildMomentsDesc(),
                Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    elevation: 20,
                    shadowColor: Colors.black26,
                    shape: const ContinuousRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(56)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 18),
                      width: double.infinity,
                      child: Image.asset(
                        'icons/ic_moments.png',
                        package: 'web3_icons',
                        height: 18,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 56,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.7, 0.9],
                        colors: [Colors.white, Color(0x00FFFFFF)],
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: GetBuilder<MomentsCardController>(
                      builder: (c) => Container(
                        height: 48,
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        alignment: Alignment.bottomCenter,
                        child: RawMaterialButton(
                          onPressed: () {
                            c.launchWelook(
                                Get.find<UserController>().ethAddress);
                          },
                          fillColor: PColor.background,
                          elevation: 0,
                          shape: const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(56),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            child: Text(
                              strUploadMoments,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.yellow.shade900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
