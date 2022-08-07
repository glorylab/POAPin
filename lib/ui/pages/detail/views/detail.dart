import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/controllers/tag.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/detail/controller.dart';
import 'package:screenshot/screenshot.dart';
import 'package:timelines/timelines.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;

class DetailView extends StatelessWidget {
  final double contentWidth;
  final bool isHorizontal;
  final DetailController controller;
  final BuildContext context;

  const DetailView(
      {Key? key,
      required this.controller,
      required this.isHorizontal,
      required this.contentWidth,
      required this.context})
      : super(key: key);

  Widget _buildID(String id) {
    Gradient g1 = const LinearGradient(
      colors: [
        Color(0xFF7F00FF),
        Color(0xFFE100FF),
      ],
    );
    return Container(
      height: 48,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: RawMaterialButton(
        fillColor: Colors.white,
        elevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
        onLongPress: () {
          controller.copy(id);
        },
        onPressed: () {
          if (controller.token.value.layer == null) {
            return;
          }
          if (controller.token.value.layer == "Layer2") {
            controller.launchURL(
                'https://blockscout.com/xdai/mainnet/token/0x22c1f6050e56d2876009903609a2cc3fef83b415/instance/$id/token-transfers');
          } else {
            controller.launchURL(
                'https://etherscan.io/nft/0x22c1f6050e56d2876009903609a2cc3fef83b415/$id');
          }
        },
        child: Container(
          height: 48,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: a.GradientText(
            'id: #$id',
            gradient: g1,
            textAlign: TextAlign.center,
            style: GoogleFonts.novaFlat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleID(String id) {
    Gradient g1 = const LinearGradient(
      colors: [
        Color(0xFF7F00FF),
        Color(0xFFE100FF),
      ],
    );
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: a.GradientText(
        '#$id',
        gradient: g1,
        textAlign: TextAlign.left,
        style: GoogleFonts.novaFlat(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black38,
        ),
      ),
    );
  }

  Widget _buildOwner(String owner) {
    Gradient g1 = const LinearGradient(
      colors: [
        Color(0xFF7F00FF),
        Color(0xFFE100FF),
      ],
    );
    return InkWell(
      onTap: () {
        if (controller.token.value.layer == null) {
          return;
        }
        if (controller.token.value.layer == "Layer2") {
          controller.launchURL(
              'https://blockscout.com/xdai/mainnet/address/$owner/tokens/0x22c1f6050e56d2876009903609a2cc3fef83b415/token-transfers');
        } else {
          controller.launchURL(
              'https://etherscan.io/token/0x22c1f6050e56d2876009903609a2cc3fef83b415?a=$owner');
        }
      },
      onLongPress: () {
        controller.copy(owner);
      },
      child: Container(
        height: 48,
        width: Get.size.width * 0.9,
        padding: const EdgeInsets.only(left: 8),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFF8F8F8), Color(0x00FFFFFF)])),
        alignment: Alignment.centerLeft,
        child: a.GradientText(
          'owner: $owner',
          gradient: g1,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: GoogleFonts.novaFlat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderAndTotal(String order, String total) {
    return Container(
      height: 48,
      color: Colors.white,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          Text(
            order,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.right,
            style: GoogleFonts.novaFlat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black12,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            '/',
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: GoogleFonts.novaFlat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black12,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            total,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.left,
            style: GoogleFonts.novaFlat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleOrderAndTotal(String order, String total) {
    Gradient g1 = const LinearGradient(
      colors: [
        Color(0xFF7F00FF),
        Color(0xFFE100FF),
      ],
    );
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          a.GradientText(
            order,
            gradient: g1,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.right,
            style: GoogleFonts.novaFlat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            '/',
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: GoogleFonts.novaFlat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black12,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          a.GradientText(
            total,
            gradient: g1,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.left,
            style: GoogleFonts.novaFlat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayerIcon(DetailController c) {
    if (c.token.value.layer == null) {
      return Container(
        width: 36,
        height: 48,
        color: Colors.white,
      );
    }

    return Container(
      alignment: Alignment.center,
      width: 36,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Image.asset(
        c.token.value.layer == 'Layer2'
            ? 'icons/ic_gnosis.png'
            : 'icons/ic_eth.png',
        package: 'web3_icons',
        width: 18.0,
        height: 18.0,
      ),
    );
  }

  SliverChildListDelegate _detailDelegate({required bool isHorizontal}) {
    return SliverChildListDelegate([
      isHorizontal
          ? Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 16),
              alignment: Alignment.centerLeft,
              child: const POAPTitle(),
            )
          : Container(),
      GetBuilder<TagController>(
        builder: (c) => c
                .getTagsInEvent(controller.token.value.event.id)
                .isEmpty
            ? Container()
            : Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                alignment: Alignment.centerLeft,
                height: 56,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: c
                      .getTagsInEvent(controller.token.value.event.id)
                      .map((t) => Container(
                          padding: const EdgeInsets.only(
                              right: 8, top: 8, bottom: 8),
                          child: RawMaterialButton(
                              fillColor: const Color(0xFFF8E7D3),
                              shape: const ContinuousRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xFFFFD5A3), width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              elevation: 0,
                              focusElevation: 0,
                              hoverElevation: 0,
                              highlightElevation: 0,
                              onPressed: () {
                                Get.toNamed(
                                  '/tag/${t.id}',
                                  arguments: t,
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  t.name,
                                  style: GoogleFonts.courierPrime(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ))))
                      .toList(),
                ),
              ),
      ),
      SizedBox(
        height: 86,
        width: double.infinity,
        child: Timeline.tileBuilder(
          scrollDirection: Axis.horizontal,
          builder: TimelineTileBuilder.connected(
              connectionDirection: ConnectionDirection.before,
              itemExtentBuilder: (_, __) => contentWidth / 3,
              contentsAlign: ContentsAlign.basic,
              contentsBuilder: (context, index) {
                return controller.getTimelineContent(index) == ''
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          controller.getTimelineTitle(index),
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: const Color(0x886534FF),
                            fontSize: 16,
                          ),
                        ),
                      );
              },
              oppositeContentsBuilder: (context, index) {
                return controller.getTimelineContent(index) == ''
                    ? Container()
                    : Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 4.0),
                          child: Text(
                            controller.getTimelineContent(index) ?? '-',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: const Color(0x886534FF),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
              },
              itemCount: 3,
              indicatorBuilder: (_, index) {
                return controller.getTimelineContent(index) == ''
                    ? Container()
                    : const Icon(
                        Icons.circle,
                        color: Color(0x886534FF),
                        size: 15.0,
                      );
              },
              connectorBuilder: (_, index, type) {
                if (index > 0) {
                  return DecoratedLineConnector(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: type == ConnectorType.start
                            ? [const Color(0x226534FF), const Color(0x116534FF)]
                            : [
                                const Color(0x116534FF),
                                const Color(0x226534FF)
                              ],
                      ),
                    ),
                  );
                }
                return null;
              }),
        ),
      ),
      controller.token.value.event.eventUrl != null &&
              controller.token.value.event.eventUrl!.isNotEmpty
          ? Card(
              color: const Color(0xFFF8F8F8),
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(0),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              shadowColor: Colors.black26,
              margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
              elevation: 8,
              child: InkWell(
                onTap: () {
                  controller.launchURL(controller.token.value.event.eventUrl!);
                },
                onLongPress: () {
                  controller.copy(controller.token.value.event.eventUrl!);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.token.value.event.eventUrl ?? '',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
      controller.getEventLocation() != ''
          ? Card(
              margin: EdgeInsets.only(
                  left: isHorizontal ? 0 : 5,
                  right: isHorizontal ? 0 : 5,
                  bottom: 0),
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(0),
                ),
              ),
              color: const Color(0xFFFDFDFD),
              shadowColor: Colors.black12,
              child: InkWell(
                onTap: () {
                  controller.copy(
                    controller.getEventLocation(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.getEventLocation(),
                          style: GoogleFonts.lato(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
      Card(
        margin: EdgeInsets.symmetric(horizontal: isHorizontal ? 0 : 8),
        elevation: 1,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.black12,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        child: InkWell(
          onTap: () {
            controller.copy(controller.token.value.event.description);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              controller.token.value.event.description,
              style: GoogleFonts.lato(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      GetBuilder<DetailController>(
          builder: (c) => SizedBox(height: c.momentsCount > 0 ? 32 : 0)),
      GetBuilder<DetailController>(
        builder: (c) {
          return c.momentsCount > 0
              ? Container(
                  height: 48,
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                  child: Material(
                    elevation: 8,
                    clipBehavior: Clip.antiAlias,
                    shadowColor: Colors.black12,
                    color: Colors.white,
                    shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: RawMaterialButton(
                      onPressed: () {
                        Get.showSnackbar(const GetSnackBar(
                          title: 'Welook Moments',
                          message:
                              'Please visit welook.io to view more moments',
                          duration: Duration(seconds: 3),
                        ));
                      },
                      fillColor: Colors.white,
                      splashColor: const Color(0x22EC4899),
                      highlightColor: const Color(0x0BEC4899),
                      elevation: 0,
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          Image.asset(
                            'icons/ic_moments.png',
                            package: 'web3_icons',
                            width: 105,
                            height: 18,
                          ),
                          const SizedBox(width: 8),
                          c.momentsCount > 0
                              ? Container(
                                  height: 30,
                                  constraints:
                                      const BoxConstraints(minWidth: 32),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(30, 236, 72, 154),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                      color: const Color(0x55EC4899),
                                      width: 3,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  child: Text(
                                    '${c.momentsCount}',
                                    style: GoogleFonts.robotoMono(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 236, 72, 154),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 30,
                                  constraints:
                                      const BoxConstraints(minWidth: 32),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(30, 236, 72, 154),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                      color: const Color(0x55EC4899),
                                      width: 3,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  child: Text(
                                    '+',
                                    style: GoogleFonts.robotoMono(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 236, 72, 154),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                          Expanded(child: Container()),
                          Image.asset(
                            'icons/ic_welook.png',
                            package: 'web3_icons',
                            width: 64,
                            height: 18,
                            color: const Color.fromARGB(30, 15, 23, 42),
                          ),
                          const SizedBox(width: 8),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                )
              : Container();
        },
      ),
      Container(
        height: 48,
        margin: EdgeInsets.symmetric(horizontal: isHorizontal ? 8 : 8),
        child: Material(
          color: Colors.white,
          elevation: 8,
          clipBehavior: Clip.antiAlias,
          shadowColor: Colors.black12,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)),
          ),
          child: Obx(
            () => Row(
              children: [
                _buildID(controller.tokenID.value),
                GetBuilder<DetailController>(
                  builder: (c) => _buildOrderAndTotal(c.order, c.total),
                ),
                Expanded(
                    child: Container(
                  color: Colors.white,
                )),
                _buildLayerIcon(controller),
              ],
            ),
          ),
        ),
      ),
      Container(
        height: 30,
        margin: EdgeInsets.symmetric(horizontal: isHorizontal ? 8 : 8),
        child: Material(
          color: PColor.background,
          elevation: 8,
          shadowColor: Colors.black12,
          clipBehavior: Clip.antiAlias,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildOwner(controller.token.value.owner),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 32),
      GetPlatform.isWeb
          ? Container()
          : SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      showMaterialModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top -
                              56,
                          child: Align(
                            child: Container(
                              width: MediaQuery.of(context).size.width < 512
                                  ? MediaQuery.of(context).size.width
                                  : 512,
                              alignment: Alignment.center,
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    GetBuilder<DetailController>(
                                      builder: (c) => Screenshot(
                                        controller:
                                            controller.screenshotController,
                                        child: Container(
                                          color: Colors.white,
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            children: [
                                              Stack(
                                                children: [
                                                  Positioned.fill(
                                                    child: Container(
                                                      child: controller
                                                              .blurBackground
                                                              .value
                                                              .isEmpty
                                                          ? Container()
                                                          : Image.memory(
                                                              controller
                                                                  .blurBackground
                                                                  .value,
                                                              fit: BoxFit.fill,
                                                              colorBlendMode:
                                                                  BlendMode
                                                                      .lighten,
                                                            ),
                                                    ),
                                                  ),
                                                  Material(
                                                    shape: c.isRound
                                                        ? const CircleBorder()
                                                        : const ContinuousRectangleBorder(),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    color: Colors.black26,
                                                    child: Container(
                                                      padding: c.isRound
                                                          ? const EdgeInsets
                                                              .all(24)
                                                          : const EdgeInsets
                                                              .all(0),
                                                      child:
                                                          ExtendedImage.network(
                                                        controller.token.value
                                                            .event.imageUrl,
                                                        cache: true,
                                                        shape: c.isRound
                                                            ? BoxShape.circle
                                                            : BoxShape
                                                                .rectangle,
                                                      ),
                                                    ),
                                                  ),
                                                  Material(
                                                    shape: c.isRound
                                                        ? const CircleBorder()
                                                        : const ContinuousRectangleBorder(),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () =>
                                                          c.toggleShape(),
                                                      child: Container(
                                                        padding: c.isRound
                                                            ? const EdgeInsets
                                                                .all(24)
                                                            : const EdgeInsets
                                                                .all(0),
                                                        child: ExtendedImage
                                                            .network(
                                                          controller.token.value
                                                              .event.imageUrl,
                                                          cache: true,
                                                          shape: c.isRound
                                                              ? BoxShape.circle
                                                              : BoxShape
                                                                  .rectangle,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              RawMaterialButton(
                                                onPressed: () {},
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            right: 16,
                                                            top: 8,
                                                            bottom: 8),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            controller
                                                                .token
                                                                .value
                                                                .event
                                                                .name,
                                                            maxLines: 3,
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .lato(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              controller.getEventLocation() !=
                                                      ''
                                                  ? Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 8),
                                                      child: Text(
                                                        controller
                                                            .getEventLocation(),
                                                        style: GoogleFonts.lato(
                                                          fontSize: 16,
                                                          color: Colors.black38,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              Row(
                                                children: [
                                                  _buildSimpleID(
                                                      controller.tokenID.value),
                                                  GetBuilder<DetailController>(
                                                    builder: (c) =>
                                                        _buildSimpleOrderAndTotal(
                                                            c.order, c.total),
                                                  ),
                                                  Expanded(child: Container()),
                                                  Image.asset(
                                                    'icons/ic_poap.png',
                                                    package: 'web3_icons',
                                                    width: 36.0,
                                                    height: 36.0,
                                                  ),
                                                  const SizedBox(width: 16),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    SizedBox(
                                      height: 56,
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          controller.share().then((value) {
                                            Get.back();
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            'Share',
                                            style: GoogleFonts.epilogue(
                                              color: const Color(0xFFFF8931),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                              .padding
                                              .bottom +
                                          16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        duration: const Duration(milliseconds: 280),
                      );
                    },
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Share',
                        style: GoogleFonts.epilogue(
                          color: const Color(0xFFFF8934),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      const SizedBox(height: 78),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if (controller.status.value == LoadingStatus.loaded &&
        controller.token.value.event.fancyID != '') {
      return SliverStickyHeader.builder(
        builder: (context, state) => isHorizontal
            ? Container()
            : Material(
                elevation: state.isPinned ? 16 : 0,
                shadowColor: Colors.black45,
                color: Colors.transparent,
                child: Container(
                  color: PColor.background,
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 4),
                  alignment: Alignment.centerLeft,
                  child: const POAPTitle(),
                ),
              ),
        sliver: SliverList(
          delegate: _detailDelegate(isHorizontal: isHorizontal),
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
  }
}

class POAPTitle extends StatelessWidget {
  const POAPTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
        builder: (c) => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                c.isGitPOAP
                    ? Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: RawMaterialButton(
                          constraints:
                              const BoxConstraints(minHeight: 32, minWidth: 32),
                          shape: const CircleBorder(),
                          onPressed: () {
                            c.launchGitPOAP(c.gitPOAPID);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              'icons/ic_gitpoap.png',
                              package: 'web3_icons',
                              width: 24.0,
                              height: 24.0,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () async {
                      await Get.toNamed(
                        '/event/${c.token.value.event.id}',
                        arguments: c.token.value.event,
                      );
                    },
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: PColor.background,
                      ),
                    ),
                    fillColor: const Color(0xFFE8E8E8),
                    elevation: 0,
                    hoverElevation: 2,
                    highlightElevation: 4,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              c.token.value.event.name,
                              maxLines: 3,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Colors.black26,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                )
              ],
            ));
  }
}
