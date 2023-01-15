import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:poapin/ui/pages/home/controllers/island.dart';
import 'package:poapin/ui/pages/watchlist/controller.dart';
import 'package:poapin/util/show_input.dart';

class DynamicIslandView extends StatelessWidget {
  const DynamicIslandView({Key? key}) : super(key: key);

  double getHeight(int progress, bool isIslandInit, BuildContext context) {
    if (!isIslandInit) {
      return 56 +
          ((MediaQuery.of(context).size.height * 0.5) * (progress / 100.0));
    }
    return 56;
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
            begin: c.isIslandInit
                ? 0
                : c.isExpanded
                    ? 0
                    : 100,
            end: c.isIslandInit
                ? 0
                : c.isExpanded
                    ? 100
                    : 0,
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
                height: getHeight(progress, c.isIslandInit, context),
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
                                      Get.put(IslandController());
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
                            ]),
                      ),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 10),
                          child: progress == 100
                              ? Container(
                                  key: const ValueKey<int>(0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      const Divider(
                                        height: 32,
                                        color: Colors.black12,
                                      ),
                                      Expanded(
                                          child: Container(
                                              child: CustomScrollView(
                                        slivers: [AddressList()],
                                      ))),
                                    ],
                                  ),
                                )
                              : Container(
                                  key: const ValueKey<int>(1),
                                ),
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
    return Container(
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
    );
  }
}

class AddressList extends StatelessWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WatchlistController controller = Get.find<WatchlistController>();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return Container(
            height: 56,
            margin: const EdgeInsets.only(bottom: 8),
            child: RawMaterialButton(
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
                  Image.asset(
                    controller.account.addresses[i].ens.isNotEmpty
                        ? 'icons/ic_ens.png'
                        : 'icons/ic_eth.png',
                    package: 'web3_icons',
                    width: 18.0,
                    height: 18.0,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: controller.account.addresses[i].ens.isNotEmpty
                            ? 8
                            : 0),
                    alignment: Alignment.center,
                    child: Text(controller.account.addresses[i].ens,
                        maxLines: 1,
                        style: GoogleFonts.courierPrime(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 20,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    width: 1,
                    color: const Color(0x186534FF),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Text(
                              controller.account.addresses[i].address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.shareTechMono(
                                color: controller
                                        .account.addresses[i].ens.isNotEmpty
                                    ? Theme.of(context).primaryColorLight
                                    : Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 4,
                            left: 0,
                            bottom: 4,
                            child: Container(
                              width: 48,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Color(0x116534FF),
                                Color(0x00FFFFFF)
                              ])),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              onPressed: () async {
                await Get.toNamed(
                        '/scan/${controller.account.addresses[i].address}')
                    ?.then((value) {
                  controller.getAccount();
                  controller.getData();
                });
              },
            ),
          );
        },
        childCount: controller.account.addresses.length,
      ),
    );
  }
}
