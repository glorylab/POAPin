import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/data/models/pref/layout.dart';
import 'package:poapin/data/models/pref/shape.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/ui/components/cache.image.dart';
import 'package:poapin/ui/components/shapes/calender_day_shape.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:rive/rive.dart' hide LinearGradient;

class MonthView extends StatelessWidget {
  final List<Token> tokens;
  final int year;
  final int month;

  const MonthView(
      {Key? key, required this.tokens, required this.year, required this.month})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();

    double getHorizontalPadding() {
      return 16;
    }

    return SliverStickyHeader.builder(
      builder: (context, state) => Material(
        elevation: state.isPinned ? 0 : 0,
        color: Colors.transparent,
        child: ClipRect(
          child: BackdropFilter(
            filter: state.isPinned
                ? ImageFilter.blur(
                    sigmaX: 10.0,
                    sigmaY: 10.0,
                  )
                : ImageFilter.blur(
                    sigmaX: 0.001,
                    sigmaY: 0.001,
                  ),
            child: Container(
                height: 56.0,
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: getHorizontalPadding()),
                    Text(
                      controller.getMonthString(month),
                      style: GoogleFonts.carterOne(
                        color: !state.isPinned ? Colors.black38 : Colors.white,
                        fontSize: 28,
                        shadows: !state.isPinned
                            ? []
                            : [
                                const Shadow(
                                    color: Color(0xFF6358EE),
                                    offset: Offset(1, 1),
                                    blurRadius: 2),
                              ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      year.toString(),
                      style: GoogleFonts.carterOne(
                        color: !state.isPinned
                            ? Colors.black12
                            : const Color(0xFFF5F5F5),
                        fontSize: 28,
                        shadows: !state.isPinned
                            ? []
                            : [
                                const Shadow(
                                    color: Color(0xFF6358EE),
                                    offset: Offset(1, 1),
                                    blurRadius: 2),
                              ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    SizedBox(width: getHorizontalPadding()),
                  ],
                )),
          ),
        ),
      ),
      sliver: SliverPadding(
        padding: EdgeInsets.only(
            left: getHorizontalPadding(),
            right: getHorizontalPadding(),
            bottom: 24,
            top: 16),
        sliver: GetBuilder<HomeController>(
          builder: (c) => controller.layout == LayoutPref.grid
              ? _GridLayout(tokens: tokens)
              : controller.layout == LayoutPref.list
                  ? _ListLayout(
                      tokens: tokens,
                    )
                  : _TimelineList(
                      year: year,
                      month: month,
                    ),
        ),
      ),
    );
  }
}

class _GridLayout extends StatelessWidget {
  final List<Token> tokens;

  const _GridLayout({Key? key, required this.tokens}) : super(key: key);
  int getCrossAxisCount(double width) {
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

  double getAxisSpacing(double width) {
    if (width > 768) {
      return 16;
    }
    return 12;
  }

  EdgeInsetsDirectional getItemPadding(double width, double extra) {
    if (Get.find<HomeController>().shape == ShapePref.round) {
      return EdgeInsetsDirectional.all(0 + extra);
    }
    if (width > 768) {
      return EdgeInsetsDirectional.all(8 + extra);
    }
    return EdgeInsetsDirectional.all(2 + extra);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double size = width / getCrossAxisCount(width);
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossAxisCount(width),
          crossAxisSpacing: getAxisSpacing(width),
          mainAxisSpacing: getAxisSpacing(width)),
      delegate: SliverChildBuilderDelegate(
        (context, i) => GetBuilder<HomeController>(
          builder: (c) => InkWell(
            onLongPress: () {
              if (!c.isEditMode) {
                c.setIsEditMode(true);
                c.setSelectedToken(tokens[i]);
              }
            },
            onTap: () async {
              if (c.isEditMode) {
                c.setSelectedToken(tokens[i]);
              } else {
                await Get.toNamed(
                  '/poap/${tokens[i].tokenId}',
                  arguments: tokens[i],
                );
              }
            },
            highlightColor: Colors.white54,
            child: Stack(
              children: [
                Container(
                  color: c.shape == ShapePref.square
                      ? Colors.white
                      : Colors.transparent,
                  child: c.shape == ShapePref.square
                      ? SizedBox(
                          width: size,
                          height: size,
                          child: Container(
                            padding: getItemPadding(width, 0),
                            child: CacheImage(
                              url: tokens[i].event.imageUrl,
                              size: width / getCrossAxisCount(width),
                              hide: c.velocity > c.hideVelocity,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: size,
                          height: size,
                          child: ClipOval(
                            child: Container(
                              alignment: Alignment.center,
                              padding: getItemPadding(width, 0),
                              margin: EdgeInsets.all(
                                (tokens[i].chain == 'homestead' ? 0 : 0),
                              ),
                              child: CacheImage(
                                url: tokens[i].event.imageUrl,
                                size: size -
                                    (tokens[i].chain == 'homestead' ? 22 : 0),
                                hide: c.velocity > c.hideVelocity,
                              ),
                            ),
                          ),
                        ),
                ),
                SparklingRing(
                  isETH: tokens[i].chain == 'homestead',
                ),
                c.isEditMode
                    ? c.isSelected(tokens[i])
                        ? Container(
                            color: Colors.green.withOpacity(0.5),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 36,
                            ),
                          )
                        : Container()
                    : Container(),
              ],
            ),
          ),
        ),
        childCount: tokens.length,
      ),
    );
  }
}

class _ListLayout extends StatelessWidget {
  final List<Token> tokens;

  const _ListLayout({Key? key, required this.tokens}) : super(key: key);

  EdgeInsetsDirectional getListImageItemPadding(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (Get.find<HomeController>().shape == ShapePref.square) {
      return const EdgeInsetsDirectional.all(0);
    }
    if (width > 768) {
      return const EdgeInsetsDirectional.all(8);
    }
    return const EdgeInsetsDirectional.all(2);
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int i) {
          return SizedBox(
            height: 88,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              clipBehavior: Clip.antiAlias,
              child: GetBuilder<HomeController>(
                builder: (c) => InkWell(
                  onLongPress: () {
                    if (!c.isEditMode) {
                      c.setIsEditMode(true);
                      c.setSelectedToken(tokens[i]);
                    }
                  },
                  onTap: () async {
                    if (c.isEditMode) {
                      c.setSelectedToken(tokens[i]);
                    } else {
                      await Get.toNamed(
                        '/poap/${tokens[i].tokenId}',
                        arguments: tokens[i],
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.1),
                            padding: getListImageItemPadding(context),
                            child: c.shape == ShapePref.square
                                ? Container(
                                    color: Colors.white,
                                    child: CacheImage(
                                      url: tokens[i].event.imageUrl,
                                      size: 80,
                                      hide: c.velocity > c.hideVelocity,
                                    ),
                                  )
                                : ClipOval(
                                    child: Container(
                                      color: Colors.white,
                                      child: CacheImage(
                                        url: tokens[i].event.imageUrl,
                                        size: 80,
                                        hide: c.velocity > c.hideVelocity,
                                      ),
                                    ),
                                  ),
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            padding: getListImageItemPadding(context),
                            child: SparklingRing(
                              isETH: tokens[i].chain == 'homestead',
                            ),
                          ),
                          c.isEditMode
                              ? c.isSelected(tokens[i])
                                  ? Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.green.withOpacity(0.5),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 36,
                                      ),
                                    )
                                  : Container()
                              : Container()
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 4),
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
                                padding:
                                    const EdgeInsets.only(bottom: 4, top: 4),
                                child: Text(
                                  tokens[i].event.description,
                                  softWrap: true,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
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
              // ),
            ),
          );
        },
        childCount: tokens.length,
      ),
    );
  }
}

class _TimelineList extends StatelessWidget {
  final int year;
  final int month;

  const _TimelineList({Key? key, required this.year, required this.month})
      : super(key: key);

  List<Widget> _buildTimelineItems(List dayMap) {
    return dayMap.map((token) {
      return _TimelineItem(
        token: token,
      );
    }).toList();
  }

  List<Widget> _buildTimelineList(data) {
    return data.map<Widget>((day) {
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
                  children: _buildTimelineItems(day.value),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => SliverList(
        delegate: SliverChildListDelegate(
          _buildTimelineList(c.filteredTokensWithDay[year]![month]!.entries),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Token token;

  const _TimelineItem({Key? key, required this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => InkWell(
        onLongPress: () {
          if (!c.isEditMode) {
            c.setIsEditMode(true);
            c.setSelectedToken(token);
          }
        },
        onTap: () async {
          if (c.isEditMode) {
            c.setSelectedToken(token);
          } else {
            await Get.toNamed(
              '/poap/${token.tokenId}',
              arguments: token,
            );
          }
        },
        highlightColor: Colors.white54,
        child: Container(
          margin: const EdgeInsets.only(top: 12, bottom: 12, left: 4, right: 4),
          child: ClipOval(
            child: SizedBox(
              width: 64,
              height: 64,
              child: Stack(
                children: [
                  CacheImage(
                    url: token.event.imageUrl,
                    size: 64,
                    hide: c.velocity > c.hideVelocity,
                  ),
                  SparklingRing(
                    isETH: token.chain == 'homestead',
                  ),
                  c.isEditMode
                      ? c.isSelected(token)
                          ? Container(
                              color: Colors.green.withOpacity(0.5),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 36,
                              ),
                            )
                          : Container()
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SparklingRing extends StatelessWidget {
  final bool isETH;

  const SparklingRing({Key? key, required this.isETH}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (!isETH) {
      return Container();
    }
    return RiveAnimation.asset(
      'assets/animation/sparkling.riv',
      fit: BoxFit.fill,
      alignment: Alignment.center,
      placeHolder: Container(),
    );
  }
}
