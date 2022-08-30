import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/controllers/tag.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/event/controller.dart';
import 'package:screenshot/screenshot.dart';
import 'package:timelines/timelines.dart';

class DetailView extends StatelessWidget {
  final double contentWidth;
  final bool isHorizontal;
  final EventDetailController controller;
  final BuildContext context;

  const DetailView(
      {Key? key,
      required this.controller,
      required this.isHorizontal,
      required this.contentWidth,
      required this.context})
      : super(key: key);

  SliverChildListDelegate _detailDelegate({required bool isHorizontal}) {
    return SliverChildListDelegate([
      isHorizontal
          ? Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 16),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      controller.event.name,
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
      GetBuilder<TagController>(
        builder: (c) => c.getTagsInEvent(controller.event.id).isEmpty
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
                      .getTagsInEvent(controller.event.id)
                      .map((t) => Container(
                          padding: const EdgeInsets.only(
                              right: 8, top: 8, bottom: 8),
                          child: RawMaterialButton(
                              fillColor: const Color(0xFFF8E7D3),
                              shape: const RoundedRectangleBorder(
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
      controller.event.eventUrl != null && controller.event.eventUrl!.isNotEmpty
          ? Card(
              color: const Color(0xFFF8F8F8),
              shape: const RoundedRectangleBorder(
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
                  controller.launchURL(controller.event.eventUrl!);
                },
                onLongPress: () {
                  controller.copy(controller.event.eventUrl!);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.event.eventUrl ?? '',
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
              shape: const RoundedRectangleBorder(
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(8),
          ),
        ),
        child: InkWell(
          onTap: () {
            controller.copy(controller.event.description);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              controller.event.description,
              style: GoogleFonts.lato(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 78),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if (controller.status.value == LoadingStatus.loaded &&
        controller.event.fancyID != '') {
      return SliverStickyHeader.builder(
        builder: (context, state) => isHorizontal
            ? Container()
            : Material(
                elevation: state.isPinned ? 16 : 0,
                shadowColor: Colors.black45,
                child: Container(
                    color: PColor.background,
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 16),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            controller.event.name,
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )),
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
