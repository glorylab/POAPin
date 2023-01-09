import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/controllers/tag.dart';
import 'package:poapin/ui/components/alerts/error.dart';
import 'package:poapin/ui/components/card.note.dart';
import 'package:poapin/ui/components/loading.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/home/components/appbar.enjoy.dart';
import 'package:poapin/ui/pages/home/components/appbar.general.dart';
import 'package:poapin/ui/pages/home/components/button.set_eth_address.dart';
import 'package:poapin/ui/pages/home/components/card.dart';
import 'package:poapin/ui/pages/home/components/fab.edit.dart';
import 'package:poapin/ui/pages/home/components/tags.filter.dart';
import 'package:poapin/ui/pages/home/components/view.island.dart';
import 'package:poapin/ui/pages/home/components/view.month.dart';
import 'package:poapin/ui/pages/home/components/view.options.dart';
import 'package:poapin/ui/pages/home/components/view.tips.empty.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class HomePage extends BasePage<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  List<Widget> _getContent(HomeController controller) {
    List<Widget> yearWrappers = [];

    /// Get all years
    controller.filteredTokens.forEach((year, tokensOfMonth) {
      for (var entry in tokensOfMonth.entries) {
        yearWrappers.add(
          MonthView(tokens: entry.value, year: year, month: entry.key),
        );
      }
    });
    return yearWrappers;
  }

  @override
  Widget getPage(BuildContext context) {
    Get.put(TagController());
    if (controller.isWebOption == true &&
        MediaQuery.of(context).size.width < 768 + 800) {
      controller.isWebOption = false;
      controller.update();
    }
    return GetBuilder<HomeController>(
      builder: (c) {
        if (controller.account.id.isEmpty) {
          return CustomScrollView(
            slivers: [
              const ENJOYALIFEWITHPOAP(),
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      left: getHorizontalPadding(context),
                      right: getHorizontalPadding(context),
                      top: 16),
                  child: NoteCard(
                    content: strSetAddress,
                    onOkTap: () {},
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                    height: 56,
                    margin: EdgeInsets.only(
                      bottom: 8,
                      top: 16,
                      left: getHorizontalPadding(context),
                      right: getHorizontalPadding(context),
                    ),
                    child: const SetETHAddressButton()),
              ),
            ],
          );
        }

        /// loading status
        if (controller.cacheLoadingStatus == CacheLoadingStatus.loading ||
            ((controller.loadingStatus == LoadingStatus.loading) &&
                controller.poapCount == 0)) {
          return const CustomScrollView(
            slivers: [
              ENJOYALIFEWITHPOAP(),
              SliverToBoxAdapter(
                child: Center(
                  child: LoadingAnimation(),
                ),
              ),
            ],
          );
        }

        /// loadedStatus
        if ((controller.cacheLoadingStatus == CacheLoadingStatus.loaded ||
            controller.loadingStatus == LoadingStatus.loaded)) {
          if (controller.poapCount == 0) {
            return const CustomScrollView(
              slivers: [
                ENJOYALIFEWITHPOAP(),
                SliverToBoxAdapter(
                  child: Center(
                    child: EmptyTips(),
                  ),
                ),
              ],
            );
          }
          return Scaffold(
            appBar: const GeneralAPPBar(),
            floatingActionButton: const EditFAB(),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    constraints: const BoxConstraints(
                        maxWidth: 768,
                        maxHeight: double.infinity,
                        minWidth: 256),
                    child: GetBuilder<HomeController>(
                      builder: (c) => Stack(
                        children: [
                          ClipRect(
                            child: AnimatedScale(
                              scale: c.isExpanded ? 1.1 : 1,
                              curve: Curves.easeInOutExpo,
                              duration: const Duration(milliseconds: 500),
                              child: CustomScrollView(
                                  controller: c.scrollController,
                                  slivers: [
                                    c.isEditMode
                                        ? SliverToBoxAdapter(
                                            child: Container(),
                                          )
                                        : SliverToBoxAdapter(
                                            child: CollectionCard(
                                              horizontalPadding:
                                                  getHorizontalPadding(context),
                                              horizonTalPaddingWithMenu:
                                                  getHorizontalPadding(context),
                                            ),
                                          ),
                                    const FilterTags(),
                                    ..._getContent(controller),
                                  ]),
                            ),
                          ),
                          TweenAnimationBuilder(
                              tween: IntTween(
                                begin: c.isExpanded ? 0 : 100,
                                end: c.isExpanded ? 100 : 0,
                              ),
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOutCubic,
                              builder: (context, int progress, child) {
                                return BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 5.0 * progress / 100.0,
                                    sigmaY: 5.0 * progress / 100.0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      c.setIslandExpanded(false);
                                    },
                                    onPanStart: (details) =>
                                        c.setIslandExpanded(false),
                                    child: IgnorePointer(
                                      ignoring: !c.isExpanded,
                                      child: Container(
                                        color: Colors.black
                                            .withOpacity(0.8 * progress / 100),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            bottom: 0,
                            left: c.isExpanded ? 0 : 6,
                            right: c.isExpanded ? 0 : 6,
                            child: const DynamicIslandView(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// On large screens, OptionsView are displayed in the sidebar.
                  Expanded(
                    child: GetBuilder<HomeController>(
                      builder: (c) =>
                          c.isWebOption ? const FlatOptionsView() : Container(),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else

        /// error
        {
          return Center(
            child: ErrorBoard(
              text: controller.error.value,
            ),
          );
        }
      },
    );
  }
}
