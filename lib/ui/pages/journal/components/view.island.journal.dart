import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/data/models/pref/layout.dart';
import 'package:poapin/data/models/pref/shape.dart';
import 'package:poapin/data/models/pref/sort.dart';
import 'package:poapin/data/models/pref/visibility.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/home/components/button.clip_shape.dart';
import 'package:poapin/ui/pages/home/components/button.layout.dart';
import 'package:poapin/ui/pages/home/components/button.sort_by.dart';
import 'package:poapin/ui/pages/home/components/button.visibility.dart';
import 'package:poapin/ui/pages/journal/controller.dart';
import 'package:poapin/ui/pages/journal/controllers/island.dart';
import 'package:poapin/ui/pages/watchlist/controller.dart';
import 'package:poapin/util/show_input.dart';

class JournalIslandView extends StatelessWidget {
  const JournalIslandView({Key? key}) : super(key: key);

  double getHeight(int progress, bool isIslandInit, BuildContext context) {
    if (!isIslandInit) {
      return 56 +
          ((MediaQuery.of(context).size.height * 0.5) * (progress / 100.0));
    }
    return 56;
  }

  double getElevation(int progress, bool isExpanded) {
    return 32 + 32 * (progress / 100.0);
  }

  BorderRadius getBorderRadius(int progress, bool isExpanded) {
    return BorderRadius.vertical(
        top: Radius.circular(66 + 24 * (progress / 100.0)));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JournalController>(
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
              elevation: getElevation(progress, c.isExpanded),
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              shape: ContinuousRectangleBorder(
                borderRadius: getBorderRadius(progress, c.isExpanded),
              ),
              child: Container(
                height: getHeight(progress, c.isIslandInit, context),
                margin: const EdgeInsets.only(top: 2, left: 3, right: 3),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      IslandHeader(),
                      Expanded(
                        child: IslandBody(),
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

class IslandHeader extends StatelessWidget {
  const IslandHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JournalController>(
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
            return Container(
              height: 56 + 120 * (progress / 100.0),
              margin: EdgeInsets.symmetric(
                  horizontal: 16 * (progress / 100.0),
                  vertical: 24 * (progress / 100.0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      elevation: 1 * (progress / 100.0),
                      highlightElevation: 0,
                      onPressed: () {
                        if (c.isExpanded) {
                          Get.put(JournalIslandController());
                          InputHelper.showContentInput(
                            context,
                            'Add some new bookmarks to life!',
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
                          topLeft:
                              Radius.circular(64 - 24 * (progress / 100.0)),
                          topRight:
                              Radius.circular(64 - 24 * (progress / 100.0)),
                          bottomLeft: Radius.circular(40 * (progress / 100.0)),
                          bottomRight: Radius.circular(40 * (progress / 100.0)),
                        ),
                      ),
                      child: GetBuilder<JournalController>(
                        builder: (c) => Row(children: [
                          const SizedBox(width: 8),
                          c.isExpanded
                              ? Icon(Icons.notes,
                                  color: PColor.primary.withOpacity(0.6),
                                  size: 24)
                              : Icon(Icons.auto_awesome,
                                  color: PColor.primary.withOpacity(0.4),
                                  size: 24),
                          const SizedBox(width: 8),
                          c.isExpanded
                              ? const Text(
                                  'A piece of text',
                                  style: TextStyle(
                                      color: Color(0xFF525252), fontSize: 16),
                                )
                              : const Text(
                                  'Add some new bookmarks to life!',
                                  style: TextStyle(
                                      color: Color(0xFFA0A0A0), fontSize: 16),
                                ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class IslandBody extends StatelessWidget {
  const IslandBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JournalController>(
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
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 10),
              child: progress == 100
                  ? SizedBox(
                      // color: Colors.green,
                      height: double.infinity,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                            child:
                            Column(children: [
                              Container(
                                height: 56 + 12,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16 * (progress / 100.0),
                                ),
                                // vertical: 24 * (progress / 100.0)),
                                child: RawMaterialButton(
                                  elevation: 1 * (progress / 100.0),
                                  highlightElevation: 0,
                                  onPressed: () {},
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
                                  child: GetBuilder<JournalController>(
                                    builder: (c) => Row(children: [
                                      const SizedBox(width: 8),
                                      Icon(Icons.explore,
                                          color: PColor.primary.withOpacity(0.6),
                                          size: 24),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Twitter URL',
                                        style: TextStyle(
                                            color: Color(0xFF525252),
                                            fontSize: 16),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              Row(children: [
                                Container(
                                  height: 180,
                                  width: 180,
                                  margin: const EdgeInsets.only(
                                    left: 16,
                                    top: 16,
                                  ),
                                  // vertical: 24 * (progress / 100.0)),
                                  child: RawMaterialButton(
                                    elevation: 1,
                                    highlightElevation: 0,
                                    onPressed: () {},
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
                                    child: GetBuilder<JournalController>(
                                      builder: (c) => Row(children: [
                                        const SizedBox(width: 8),
                                        Icon(Icons.music_note,
                                            color: PColor.primary.withOpacity(0.6),
                                            size: 24),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Music',
                                          style: TextStyle(
                                              color: Color(0xFF525252),
                                              fontSize: 16),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                                Expanded(child: Container(
                                  height: 180,
                                  margin: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                  ),
                                  // vertical: 24 * (progress / 100.0)),
                                  child: RawMaterialButton(
                                    elevation: 1,
                                    highlightElevation: 0,
                                    onPressed: () {},
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
                                    child: GetBuilder<JournalController>(
                                      builder: (c) => Row(children: [
                                        const SizedBox(width: 8),
                                        Icon(Icons.image,
                                            color: PColor.primary.withOpacity(0.6),
                                            size: 24),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Image or video',
                                          style: TextStyle(
                                              color: Color(0xFF525252),
                                              fontSize: 16),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),)
                              ],),
                              
                            ],),

                          ),

                          // Positioned(
                          //   top: 0,
                          //   left: 0,
                          //   right: 0,
                          //   child: IgnorePointer(
                          //     child: Container(
                          //       height: 56,
                          //       decoration: const BoxDecoration(
                          //         gradient: LinearGradient(
                          //           colors: [
                          //             Color(0xFFFFFFFF),
                          //             Color(0x00FFFFFF),
                          //           ],
                          //           begin: Alignment.topCenter,
                          //           end: Alignment.bottomCenter,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  : Container(
                      key: const ValueKey<int>(1),
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

class OptionsView extends StatelessWidget {
  const OptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 16),
          child: Text(
            strVisibility,
            style: GoogleFonts.epilogue(fontSize: 16, color: Colors.black54),
          ),
        ),
        SizedBox(
          height: 56,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 16,
              ),
              VisibilityButton(
                icon: Icons.unfold_less_rounded,
                label: strHideDuplicates,
                visibility: VisibilityPref.hideDuplicates,
              ),
              const SizedBox(
                width: 8,
              ),
              VisibilityButton(
                icon: Icons.unfold_more_rounded,
                label: strShowAll,
                visibility: VisibilityPref.showAll,
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
          child: Text(
            strSort,
            style: GoogleFonts.epilogue(fontSize: 16, color: Colors.black54),
          ),
        ),
        SizedBox(
          height: 56,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 16,
              ),
              SortByButton(
                icon: Icons.arrow_upward,
                label: strNewest,
                sortBy: SortPref.timeAsc,
              ),
              const SizedBox(
                width: 8,
              ),
              SortByButton(
                icon: Icons.arrow_downward,
                label: strOldest,
                sortBy: SortPref.timeDesc,
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
          child: Text(
            strShape,
            style: GoogleFonts.epilogue(fontSize: 16, color: Colors.black54),
          ),
        ),
        SizedBox(
          height: 112,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 16,
              ),
              Builder(builder: (context) {
                return const ClipShapeButton(
                  shape: ShapePref.square,
                  image: 'shape_square',
                );
              }),
              const SizedBox(
                width: 8,
              ),
              const ClipShapeButton(
                shape: ShapePref.round,
                image: 'shape_circle',
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
          child: Text(
            'Layout',
            style: GoogleFonts.epilogue(fontSize: 16, color: Colors.black54),
          ),
        ),
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
          height: 112,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 16,
              ),
              Builder(builder: (context) {
                return const LayoutButton(
                  layout: LayoutPref.grid,
                  image: 'layout_grid',
                );
              }),
              const SizedBox(
                width: 8,
              ),
              Builder(builder: (context) {
                return const LayoutButton(
                  layout: LayoutPref.list,
                  image: 'layout_list',
                );
              }),
              const SizedBox(
                width: 8,
              ),
              Builder(builder: (context) {
                return const LayoutButton(
                  isDisabled: false,
                  layout: LayoutPref.timeline,
                  image: 'layout_timeline',
                );
              }),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
