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
import 'package:poapin/ui/pages/event/controller.dart';
import 'package:poapin/ui/pages/event/views/detail.dart';
import 'package:poapin/ui/pages/event/views/page.base_info.dart';
import 'package:poapin/ui/pages/event/views/page.moments.dart';

class EventDetailPage extends BasePage<EventDetailController> {
  const EventDetailPage({Key? key}) : super(key: key);

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
  final EventDetailController controller;

  const _HorizontalView({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1024) {
      width = 1024;
    }
    double contentWidth = width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.event.id == 0 ? 'POAP.in' : '#${controller.event.id}',
          overflow: TextOverflow.fade,
          style: GoogleFonts.shareTechMono(
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
        actions: [
          IconButton(
              onPressed: () {
                controller.addTag();
              },
              icon: Image.asset(
                'assets/common/ic_tag.png',
                width: 28,
                height: 28,
              )),
        ],
      ),
      body: GetBuilder<EventDetailController>(
        builder: (c) => SafeArea(
          child: c.status.value == LoadingStatus.loading && c.eventID == 0
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
                                tag: c.eventID,
                                child: GetBuilder<EventDetailController>(
                                  builder: (c) => Material(
                                    shape: c.isRound
                                        ? const CircleBorder()
                                        : const RoundedRectangleBorder(),
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => c.toggleShape(),
                                      child: ExtendedImage.network(
                                        c.event.imageUrl,
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
  final EventDetailController controller;

  const _VerticalView({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          PageView.builder(
              controller: controller.pageController,
              itemCount: 2,
              pageSnapping: true,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const BaseInfoView();
                  case 1:
                    return const MomentsInEventPage();

                  default:
                    return Container();
                }
              }),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 256 + MediaQuery.of(context).padding.top,
              child: Material(
                elevation: 24,
                shadowColor: Colors.black45,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom:
                        Radius.circular(MediaQuery.of(context).size.width / 3),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: controller.status.value == LoadingStatus.loaded
                    ? Stack(children: [
                        GetBuilder<EventDetailController>(
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
                          left: 0,
                          right: 0,
                          bottom: 0,
                          top: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [
                                const Color(0x00F2F2F2),
                                PColor.background
                              ],
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
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 56,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const IgnorePointer(
                                      child: GoBackButton(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GetBuilder<EventDetailController>(
                                    builder: (c) => Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .padding
                                                  .top +
                                              16,
                                          bottom: 16),
                                      child: Material(
                                        shape: c.isRound
                                            ? const CircleBorder()
                                            : const RoundedRectangleBorder(),
                                        clipBehavior: Clip.antiAlias,
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => c.toggleShape(),
                                          child: ExtendedImage.network(
                                            controller.event.imageUrl,
                                            fit: BoxFit.scaleDown,
                                            cache: true,
                                            shape: c.isRound
                                                ? BoxShape.circle
                                                : BoxShape.rectangle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 56,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ])
                    : Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
