import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:poapin/util/show_input.dart';

class DynamicIslandView extends StatelessWidget {
  const DynamicIslandView({Key? key}) : super(key: key);

  double getHeight(int progress, bool isExpanded, BuildContext context) {
    return 56 +
        ((MediaQuery.of(context).size.height * 0.5) * (progress / 100.0));
  }

  double getElavation(int progress, bool isExpanded) {
    return 32 + 32 * (progress / 100.0);
  }

  BorderRadius getBorderRadius(int progress, bool isExpanded) {
    return BorderRadius.vertical(
        top: Radius.circular(66 + 24 * (progress / 100.0)));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) {
        return TweenAnimationBuilder(
          tween: IntTween(
            begin: c.isExpanded ? 0 : 100,
            end: c.isExpanded ? 100 : 0,
          ),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          builder: (context, int progress, child) {
            return Material(
              elevation: getElavation(progress, c.isExpanded),
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              shape: ContinuousRectangleBorder(
                borderRadius: getBorderRadius(progress, c.isExpanded),
              ),
              child: Container(
                height: getHeight(progress, c.isExpanded, context),
                margin: const EdgeInsets.only(top: 2, left: 3, right: 3),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        height: 56 + 12 * (progress / 100.0),
                        margin: EdgeInsets.symmetric(
                            horizontal: 16 * (progress / 100.0),
                            vertical: 24 * (progress / 100.0)),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: RawMaterialButton(
                                  elevation: 2 + 6 * (progress / 100.0),
                                  highlightElevation: 0,
                                  onPressed: () {
                                    if (c.isExpanded) {
                                      InputHelper.showBottomInput(
                                        context,
                                        'strEthAddressOrEns',
                                        c.addressController,
                                        c.onAddressSubmit,
                                      );
                                      // Get.to(
                                      //   () => const IslandView(),
                                      //   opaque: true,
                                      //   transition: Transition.downToUp,
                                      // );
                                    } else {
                                      c.setIslandExpanded(!c.isExpanded);
                                    }
                                  },
                                  fillColor: const Color(0xFFF6F6F6),
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          64 - 24 * (progress / 100.0)),
                                      topRight: Radius.circular(
                                          64 - 24 * (progress / 100.0)),
                                      bottomLeft: Radius.circular(
                                          40 * (progress / 100.0)),
                                      bottomRight: Radius.circular(
                                          40 * (progress / 100.0)),
                                    ),
                                  ),
                                  child: Row(children: [
                                    const SizedBox(width: 8),
                                    Image.asset(
                                      'icons/ic_poap.png',
                                      package: 'web3_icons',
                                      color: PColor.primary.withOpacity(0.4),
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'poap.eth',
                                      style: TextStyle(
                                          color: Color(0xFFA0A0A0),
                                          fontSize: 16),
                                    ),
                                  ]),
                                ),
                              ),
                              // IconButton(
                              //   icon:
                              //       const Icon(Icons.keyboard_double_arrow_up_rounded),
                              //   onPressed: () {},
                              // ),
                            ]),
                      ),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: progress == 100
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Text(
                                        'To browse POAP collections, enter an Ethereum address, ENS, or email address.',
                                        style: GoogleFonts.robotoMono(
                                          color:
                                              PColor.primary.withOpacity(0.4),
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Divider(
                                        height: 32,
                                        color: Colors.black12,
                                      ),
                                      Expanded(
                                          child: Container(
                                        child: ListView.builder(
                                          itemCount: 10,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'icons/ic_poap.png',
                                                    package: 'web3_icons',
                                                    color: PColor.primary
                                                        .withOpacity(0.4),
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'POAP',
                                                          style: GoogleFonts
                                                              .robotoMono(
                                                            color: PColor
                                                                .primary
                                                                .withOpacity(
                                                                    0.4),
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          'POAP is a non-fungible token (NFT) standard for event attendance. It is a way to prove you attended an event and to collect them all.',
                                                          style: GoogleFonts
                                                              .robotoMono(
                                                            color: PColor
                                                                .primary
                                                                .withOpacity(
                                                                    0.4),
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )),
                                    ],
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class IslandView extends StatelessWidget {
  const IslandView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'island',
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Container(
              margin: const EdgeInsets.all(32),
              child: const Material(
                child: Center(
                  child: Text(
                    'Island',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
