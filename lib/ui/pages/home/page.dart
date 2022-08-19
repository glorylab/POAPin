import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/controllers/tag.dart';
import 'package:poapin/ui/components/alerts/error.dart';
import 'package:poapin/ui/components/card.note.dart';
import 'package:poapin/ui/components/loading.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/home/components/card.dart';
import 'package:poapin/ui/pages/home/components/tags.filter.dart';
import 'package:poapin/ui/pages/home/components/view.month.dart';
import 'package:poapin/ui/pages/home/components/view.options.dart';
import 'package:poapin/ui/pages/home/components/view.tips.empty.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:poapin/ui/pages/me/controller.dart';
import 'package:poapin/util/show_input.dart';
import 'package:rive/rive.dart' hide LinearGradient;

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
              SliverAppBar(
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
                          child: RiveAnimation.asset(
                            'assets/animation/dynamic_bg.riv',
                            fit: BoxFit.cover,
                            placeHolder: Container(
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
                      SafeArea(
                        child: Center(
                          child: Text(
                            'Enjoy a life with POAP.',
                            style: GoogleFonts.carterOne(
                              color: Colors.white70,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                floating: true,
                pinned: true,
                expandedHeight: 256,
              ),
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      left: getHorizontalPadding(context),
                      right: getHorizontalPadding(context),
                      top: 16),
                  child: NoteCard(
                    content:
                        'Set your address and you\'ll see your POAPs on the home page.',
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
                        const Icon(Icons.auto_awesome),
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Set ETH address',
                            maxLines: 1,
                            style: GoogleFonts.courierPrime(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      controller.handlePress();
                      InputHelper.showBottomInput(
                          context,
                          'ETH address or ENS',
                          Get.find<MeController>().addressController,
                          Get.find<MeController>().onSubmit);
                    },
                  ),
                ),
              ),
            ],
          );
        }

        /// loading status
        if (controller.cacheLoadingStatus == CacheLoadingStatus.loading ||
            ((controller.loadingStatus == LoadingStatus.loading) &&
                controller.count == 0)) {
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
          if (controller.count == 0) {
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
            appBar: AppBar(
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
                            c.isEditMode
                                ? 'Edit POAPs'
                                : 'Enjoy a life with POAP.',
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
              actions: [
                GetBuilder<HomeController>(
                  builder: (c) => c.isEditMode
                      ? RawMaterialButton(
                          onPressed: () {
                            controller.clearSelectedTokens();
                            controller.setIsEditMode(false);
                          },
                          child: Row(
                            children: [
                              Text(
                                'Done',
                                style: GoogleFonts.epilogue(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ))
                      : Container(),
                ),
              ],
            ),
            floatingActionButton: GetBuilder<HomeController>(
                builder: (c) => c.isEditMode && c.selectedTokens.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FloatingActionButton.extended(
                            onPressed: () {
                              c.editTag();
                            },
                            label: const Text('Edit tags'),
                          ),
                          const SizedBox(height: 16),
                          FloatingActionButton.extended(
                            onPressed: () {
                              c.hidePOAPs();
                            },
                            label: const Text('Hide POAPs'),
                          ),
                        ],
                      )
                    : Container()),
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
                      builder: (c) => CustomScrollView(
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

class ENJOYALIFEWITHPOAP extends StatelessWidget {
  const ENJOYALIFEWITHPOAP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
                child: RiveAnimation.asset(
                  'assets/animation/dynamic_bg.riv',
                  fit: BoxFit.cover,
                  placeHolder: Container(
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
            SafeArea(
              child: Center(
                child: Text(
                  'Enjoy a life with POAP.',
                  style: GoogleFonts.carterOne(
                    color: Colors.white70,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floating: true,
      pinned: true,
      expandedHeight: 256,
    );
  }
}
