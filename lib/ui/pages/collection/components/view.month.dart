import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/data/models/pref/layout.dart';
import 'package:poapin/data/models/pref/shape.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/components/shapes/calender_day_shape.dart';
import 'package:poapin/ui/pages/collection/controller.dart';

class MonthView extends StatelessWidget {
  final List<Token> tokens;
  final int year;
  final int month;

  const MonthView(
      {Key? key, required this.tokens, required this.year, required this.month})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    CollectionController controller = Get.find<CollectionController>();
    double width = MediaQuery.of(context).size.width;

    int getCrossAxisCount() {
      if (width > 768) {
        return 6;
      } else if (width <= 768 && width > 600) {
        return 5;
      } else if (width <= 768 && width > 600) {
        return 4;
      } else if (width <= 600 && width > 400) {
        return 3;
      } else if (width <= 400 && width > 200) {
        return 3;
      } else if (width <= 200 && width > 10) {
        return 2;
      }
      return 1;
    }

    double getAxisSpacing() {
      if (width > 768) {
        return 16;
      }
      return 4;
    }

    EdgeInsetsDirectional getItemPadding() {
      if (Get.find<CollectionController>().shape.value == ShapePref.round) {
        return const EdgeInsetsDirectional.all(0);
      }
      if (width > 768) {
        return const EdgeInsetsDirectional.all(8);
      }
      return const EdgeInsetsDirectional.all(2);
    }

    EdgeInsetsDirectional getListImageItemPadding() {
      if (Get.find<CollectionController>().shape.value == ShapePref.square) {
        return const EdgeInsetsDirectional.all(0);
      }
      if (width > 768) {
        return const EdgeInsetsDirectional.all(8);
      }
      return const EdgeInsetsDirectional.all(2);
    }

    double getHorizontalPadding() {
      if (width > 768) {
        return (width - 768) / 2;
      } else {
        return 16;
      }
    }

    return SliverStickyHeader.builder(
      builder: (context, state) => Material(
        elevation: state.isPinned ? 2 : 0,
        child: Container(
            height: 56.0,
            color: PColor.background,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: getHorizontalPadding()),
                Text(
                  controller.getMonthString(month),
                  style: GoogleFonts.carterOne(
                      color: Colors.black38, fontSize: 28),
                ),
                const SizedBox(width: 12),
                Text(
                  year.toString(),
                  style: GoogleFonts.carterOne(
                      color: Colors.black12, fontSize: 28),
                ),
                Expanded(
                  child: Container(),
                ),
                SizedBox(width: getHorizontalPadding()),
              ],
            )),
      ),
      sliver: SliverPadding(
        padding: EdgeInsets.only(
            left: getHorizontalPadding(),
            right: getHorizontalPadding(),
            bottom: 24,
            top: 16),
        sliver: Obx(
          () => controller.layout.value == LayoutPref.grid
              ? SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: getCrossAxisCount(),
                      crossAxisSpacing: getAxisSpacing(),
                      mainAxisSpacing: getAxisSpacing()),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => InkWell(
                      onTap: () async {
                        await Get.toNamed(
                          '/poap/${tokens[i].tokenId}',
                          arguments: tokens[i],
                        );
                      },
                      highlightColor: Colors.white54,
                      child: Obx(
                        () => Container(
                          color: controller.shape.value == ShapePref.square
                              ? Colors.white
                              : Colors.transparent,
                          child: controller.shape.value == ShapePref.square
                              ? SizedBox(
                                  width: width / getCrossAxisCount(),
                                  height: width / getCrossAxisCount(),
                                  child: Container(
                                    padding: getItemPadding(),
                                    child: Hero(
                                        tag: tokens[i].tokenId,
                                        child: ExtendedImage.network(
                                          tokens[i].event.imageUrl,
                                          width: width / getCrossAxisCount(),
                                          height: width / getCrossAxisCount(),
                                          cache: true,
                                        )),
                                  ),
                                )
                              : ClipOval(
                                  child: SizedBox(
                                    width: width / getCrossAxisCount(),
                                    height: width / getCrossAxisCount(),
                                    child: Container(
                                      padding: getItemPadding(),
                                      child: Hero(
                                          tag: tokens[i].tokenId,
                                          child: ExtendedImage.network(
                                            tokens[i].event.imageUrl,
                                            width: width / getCrossAxisCount(),
                                            height: width / getCrossAxisCount(),
                                            cache: true,
                                          )),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    childCount: tokens.length,
                  ),
                )
              : controller.layout.value == LayoutPref.list
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int i) {
                          return SizedBox(
                            height: 88,
                            child: Obx(
                              () => Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () async {
                                    await Get.toNamed(
                                        '/poap/${tokens[i].tokenId}',
                                        arguments: tokens[i]);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        padding: getListImageItemPadding(),
                                        child: controller.shape.value ==
                                                ShapePref.square
                                            ? Container(
                                                color: Colors.white,
                                                child: Hero(
                                                    tag: tokens[i].tokenId,
                                                    child:
                                                        ExtendedImage.network(
                                                      tokens[i].event.imageUrl,
                                                      width: 80,
                                                      height: 80,
                                                      cache: true,
                                                    )),
                                              )
                                            : ClipOval(
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Hero(
                                                      tag: tokens[i].tokenId,
                                                      child:
                                                          ExtendedImage.network(
                                                        tokens[i]
                                                            .event
                                                            .imageUrl,
                                                        width: 80,
                                                        height: 80,
                                                        cache: true,
                                                      )),
                                                ),
                                              ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                tokens[i].event.name,
                                                maxLines: 3,
                                                softWrap: true,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4, top: 4),
                                                child: Text(
                                                  tokens[i].event.description,
                                                  softWrap: true,
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.lato(
                                                    fontSize: 13,
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: tokens.length,
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        controller
                            .filteredTokensWithDay.value[year]![month]!.entries
                            .map((day) {
                          return Card(
                            shape: const CalenderDayShapeBorder(),
                            shadowColor: Colors.black26,
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox(
                              width: double.infinity,
                              height: 88,
                              child: Row(
                                children: [
                                  Container(
                                    width: 88,
                                    height: 88,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      '${day.key}',
                                      style: GoogleFonts.lato(
                                        fontSize: 36,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: day.value.map((token) {
                                          return InkWell(
                                            onTap: () async {
                                              await Get.toNamed(
                                                '/poap/${token.tokenId}',
                                                arguments: token,
                                              );
                                            },
                                            highlightColor: Colors.white54,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 12,
                                                  bottom: 12,
                                                  left: 4,
                                                  right: 4),
                                              child: ClipOval(
                                                child: SizedBox(
                                                  width: 64,
                                                  height: 64,
                                                  child: Hero(
                                                      tag: token.tokenId,
                                                      child:
                                                          ExtendedImage.network(
                                                        token.event.imageUrl,
                                                        width: 64,
                                                        height: 64,
                                                        cache: true,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList()),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
        ),
      ),
    );
  }
}
