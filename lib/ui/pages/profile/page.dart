import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/controllers/controller.user.dart';
import 'package:poapin/ui/components/buttons/back.dart';
import 'package:poapin/ui/components/buttons/go_home.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/profile/controller.dart';
import 'package:poapin/util/show_input.dart';

class ProfilePage extends BasePage<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Get.previousRoute == ''
            ? const GoHomeButton()
            : const GoBackButton(),
        elevation: 0,
        title: Text(
          'Profile',
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
      body: ListView(children: [ProfileCard()]),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.white,
        shadowColor: Colors.black12,
        elevation: 12,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.zero, bottom: Radius.circular(88)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              const SizedBox(width: 16),
              GetBuilder<ProfileController>(builder: (c) {
                return Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      InputHelper.showBottomInput(context, 'ETH address or ENS',
                          c.addressController, c.onSubmit);
                    },
                    fillColor: Colors.white,
                    elevation: 0,
                    focusElevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(36),
                      ),
                    ),
                    child: Container(
                      height: 88,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: GetBuilder<UserController>(
                        builder: (uc) => Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FittedBox(
                                    alignment: Alignment.centerLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      c.ensAddress == ''
                                          ? 'Anonymous'
                                          : c.ensAddress,
                                      maxLines: 1,
                                      style: GoogleFonts.pressStart2p(
                                        color: (uc.isSignedIn &&
                                                uc.user.eth.isNotEmpty)
                                            ? const Color(0x886534FF)
                                            : Colors.black54,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                              offset: const Offset(2, 1),
                                              blurRadius: 0),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    c.ethAddress == ''
                                        ? 'Set ETH address'
                                        : c.getSimpleAddress(c.ethAddress),
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.pressStart2p(
                                      color: (uc.isSignedIn &&
                                              uc.user.eth.isNotEmpty)
                                          ? const Color(0x886534FF)
                                          : Colors.black54,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
