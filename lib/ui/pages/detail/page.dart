import 'package:dismissible_page/dismissible_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/components/buttons/back.dart';
import 'package:poapin/ui/components/buttons/go_home.dart';
import 'package:poapin/ui/components/loading.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/artwork/page.dart';
import 'package:poapin/ui/pages/detail/controller.dart';
import 'package:poapin/ui/pages/detail/views/detail.dart';

class DetailPage extends BasePage<DetailController> {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (width / height > 0.8) {
      return _HorizontalView(
        controller: controller,
      );
    }
    return _VerticalView(
      controller: controller,
    );
  }
}

class _HorizontalView extends StatelessWidget {
  final DetailController controller;

  const _HorizontalView({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1024) {
      width = 1024;
    }
    double contentWidth = width / 2;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            'POAP.in',
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
          leading: Get.previousRoute == ''
              ? const GoHomeButton()
              : const GoBackButton(),
        ),
        body: SafeArea(
          child: controller.status.value == LoadingStatus.loading &&
                  controller.token.value.tokenId == ''
              ? const Center(
                  child: LoadingAnimation(),
                )
              : Stack(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 512),
                        width: (MediaQuery.of(context).size.height - 88 <
                                contentWidth)
                            ? MediaQuery.of(context).size.height - 88
                            : contentWidth,
                        child: Stack(children: [
                          Positioned(
                            left: 16,
                            right: 0,
                            top: 16,
                            child: Container(
                              margin: EdgeInsets.only(top: Get.statusBarHeight),
                              padding: const EdgeInsets.all(16),
                              child: Hero(
                                tag: controller.token.value.tokenId,
                                child: GetBuilder<DetailController>(
                                  builder: (c) => Material(
                                    shape: c.isRound
                                        ? const CircleBorder()
                                        : const RoundedRectangleBorder(),
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => c.toggleShape(),
                                      child: ExtendedImage.network(
                                        controller.token.value.event.imageUrl,
                                        cache: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 512),
                        width: contentWidth,
                        child: CustomScrollView(
                          slivers: [
                            DetailView(
                              controller: controller,
                              contentWidth: contentWidth,
                              isHorizontal: true,
                              context: context,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ])
                  ],
                ),
        ),
      ),
    );
  }
}

class _VerticalView extends StatelessWidget {
  final DetailController controller;

  const _VerticalView({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            leading: Get.previousRoute == ''
                ? const GoHomeButton()
                : const GoBackButton(),
            backgroundColor: Colors.white,
            title: Text(
              'POAP.in',
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
            expandedHeight: controller.status.value == LoadingStatus.loaded
                ? context.width
                : 56,
            collapsedHeight: controller.status.value == LoadingStatus.loaded
                ? 56 + context.width / 2
                : 56,
            flexibleSpace: controller.status.value == LoadingStatus.loaded
                ? Stack(children: [
                    GetBuilder<DetailController>(
                      builder: (c) => Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          color: c.backgroundColor,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        child: controller.blurBackground.value.isEmpty
                            ? Container()
                            : Image.memory(
                                controller.blurBackground.value,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [const Color(0x00F2F2F2), PColor.background],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: GetPlatform.isWeb ? 56 : 0,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 56 + MediaQuery.of(context).viewPadding.top),
                        padding: const EdgeInsets.all(16),
                        child: GetBuilder<DetailController>(
                          builder: (c) => Material(
                            shape: c.isRound
                                ? const CircleBorder()
                                : const RoundedRectangleBorder(),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => context.pushTransparentRoute(
                                ArtworkPage(
                                  imageUrl: c.token.value.event.imageUrl,
                                ),
                              ),
                              child: Hero(
                                tag: controller.token.value.event.imageUrl,
                                child: ExtendedImage.network(
                                  controller.token.value.event.imageUrl,
                                  cache: true,
                                  fit: BoxFit.scaleDown,
                                  shape: c.isRound
                                      ? BoxShape.circle
                                      : BoxShape.rectangle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])
                : Container(),
          ),
          DetailView(
            controller: controller,
            contentWidth: MediaQuery.of(context).size.width,
            isHorizontal: false,
            context: context,
          ),
          controller.status.value == LoadingStatus.loading &&
                  controller.token.value.tokenId == ''
              ? const SliverFillRemaining(
                  child: Center(
                    child: LoadingAnimation(),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Container(),
                ),
        ],
      ),
    );
  }
}
