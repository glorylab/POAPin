import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/ui/components/cache.image.dart';
import 'package:poapin/ui/components/card.note.dart';
import 'package:poapin/ui/components/loading.dart';
import 'package:poapin/ui/components/shapes/calender_day_shape.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/home/components/view.month.dart';
import 'package:poapin/ui/pages/watchlist/controller.dart';
import 'package:poapin/util/screen.dart';
import 'package:poapin/util/show_input.dart';
import 'package:rive/rive.dart' hide LinearGradient;

class WatchlistPage extends BasePage<WatchlistController> {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    return GestureDetector(
      child: GetBuilder<WatchlistController>(
        builder: (c) => Container(
          child: c.account.id == '' && c.account.addresses.isEmpty
              ? WelcomeView(
                  watchlistController: c,
                  horizontalPadding: getHorizontalPadding(context),
                )
              : IndexHomeView(
                  watchlistController: c,
                ),
        ),
      ),
    );
  }
}

class WelcomeView extends StatelessWidget {
  final WatchlistController watchlistController;
  final double horizontalPadding;

  const WelcomeView(
      {Key? key,
      required this.watchlistController,
      required this.horizontalPadding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                      'gm',
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
              left: horizontalPadding,
              right: horizontalPadding,
              top: 16,
              bottom: 16,
            ),
            child: NoteCard(
              content: 'You can add some addresses you are interested in here.',
              onOkTap: () {},
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 56,
            margin: EdgeInsets.only(
                bottom: 8, left: horizontalPadding, right: horizontalPadding),
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
                      'Add your first collection',
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
                InputHelper.showBottomInput(
                    context,
                    'ETH address or ENS',
                    watchlistController.addressController,
                    watchlistController.onSubmit);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class IndexHomeView extends StatelessWidget {
  final WatchlistController watchlistController;

  const IndexHomeView({Key? key, required this.watchlistController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatchlistController>(builder: (c) {
      if (c.account.addresses.isEmpty) {
        return CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 12,
              automaticallyImplyLeading: false,
              leading: null,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                'Watchlist',
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
              actions: [
                GetBuilder<WatchlistController>(
                  builder: (c) => c.isTimelineLayout
                      ? IconButton(
                          onPressed: () {
                            c.toggleLayout();
                          },
                          icon: const Icon(Icons.dynamic_form_outlined),
                        )
                      : IconButton(
                          onPressed: () {
                            c.toggleLayout();
                          },
                          icon: const Icon(Icons.receipt_long_outlined),
                        ),
                ),
                IconButton(
                  onPressed: () {
                    InputHelper.showBottomInput(
                        context,
                        'ETH address or ENS',
                        watchlistController.addressController,
                        watchlistController.onSubmit);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenHelper.getHorizontalPadding(context),
              ),
              sliver: _EmptyWatchlist(),
            ),
          ],
        );
      } else {
        if (c.isTimelineLayout) {
          return CustomScrollView(
            controller: c.scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 12,
                automaticallyImplyLeading: false,
                leading: null,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text(
                  'Watchlist',
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
                actions: [
                  GetBuilder<WatchlistController>(
                    builder: (c) => c.isTimelineLayout
                        ? IconButton(
                            onPressed: () {
                              c.toggleLayout();
                            },
                            icon: const Icon(Icons.dynamic_form_outlined),
                          )
                        : IconButton(
                            onPressed: () {
                              c.toggleLayout();
                            },
                            icon: const Icon(Icons.receipt_long_outlined),
                          ),
                  ),
                  IconButton(
                    onPressed: () {
                      InputHelper.showBottomInput(
                          context,
                          'ETH address or ENS',
                          watchlistController.addressController,
                          watchlistController.onSubmit);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              c.tokens.isEmpty && c.loadingStatus == LoadingStatus.loading
                  ? const SliverFillRemaining(
                      child: Center(
                        child: LoadingAnimation(),
                      ),
                    )
                  : const SliverToBoxAdapter(),
              _buildHeader(context),
              ..._getContent(),
            ],
          );
        }
        return CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 12,
              automaticallyImplyLeading: false,
              leading: null,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                'Watchlist',
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
              actions: [
                GetBuilder<WatchlistController>(
                  builder: (c) => c.isTimelineLayout
                      ? IconButton(
                          onPressed: () {
                            c.toggleLayout();
                          },
                          icon: const Icon(Icons.dynamic_form_outlined),
                        )
                      : IconButton(
                          onPressed: () {
                            c.toggleLayout();
                          },
                          icon: const Icon(Icons.receipt_long_outlined),
                        ),
                ),
                IconButton(
                  onPressed: () {
                    InputHelper.showBottomInput(
                        context,
                        'ETH address or ENS',
                        watchlistController.addressController,
                        watchlistController.onSubmit);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenHelper.getHorizontalPadding(context),
                vertical: 16,
              ),
              sliver: _AddressList(),
            )
          ],
        );
      }
    });
  }
}

String getSimpleAddress(String address) {
  if (address.length > 14) {
    return address.substring(0, 6) +
        '...' +
        address.substring(address.length - 4);
  }
  return address;
}

Widget _buildHeader(BuildContext context) {
  List _addresses = Get.find<WatchlistController>().account.addresses;
  return SliverToBoxAdapter(
    child: Container(
      height: 48,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenHelper.getFullHorizontalPadding(context),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0 || index == _addresses.length + 1) {
            return const SizedBox(width: 16);
          }
          return Card(
            elevation: 1,
            shadowColor: Colors.black54,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              alignment: Alignment.center,
              child: Text(
                _addresses[index - 1].ens == ''
                    ? getSimpleAddress(_addresses[index - 1].address)
                    : _addresses[index - 1].ens,
                style: GoogleFonts.courierPrime(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 20,
                ),
              ),
            ),
          );
        },
        itemCount: _addresses.length + 2,
      ),
    ),
  );
}

List<Widget> _getContent() {
  List<Widget> yearWrappers = [];

  /// Get all years
  Get.find<WatchlistController>().filteredTokens.forEach((year, tokensOfMonth) {
    for (var entry in tokensOfMonth.entries) {
      yearWrappers.add(
        _DayView(tokens: entry.value, year: year, month: entry.key),
      );
    }
  });
  return yearWrappers;
}

class _DayView extends StatelessWidget {
  final List<Token> tokens;
  final int year;
  final int month;

  const _DayView(
      {Key? key, required this.tokens, required this.year, required this.month})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getHorizontalPadding() {
      double width = MediaQuery.of(context).size.width;
      if (width > 768) {
        return (width - 768) / 2;
      } else {
        return 16;
      }
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
                      Get.find<WatchlistController>().getMonthString(month),
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
      sliver: GetBuilder<WatchlistController>(
        builder: (c) => SliverPadding(
          padding: EdgeInsets.only(
              left: getHorizontalPadding(),
              right: getHorizontalPadding(),
              bottom: 24,
              top: 16),
          sliver: _TimelineList(
            year: year,
            month: month,
          ),
        ),
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
    return GetBuilder<WatchlistController>(
      builder: (c) => SliverList(
        delegate: SliverChildListDelegate(
          _buildTimelineList(c.filteredTokensWithDay[year]![month]!.entries),
        ),
      ),
    );
  }
}

class _AddressList extends StatelessWidget {
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

class _EmptyWatchlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      height: 56,
      margin: const EdgeInsets.only(bottom: 8, top: 16),
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
              child: Text('Add your first collection',
                  maxLines: 1,
                  style: GoogleFonts.courierPrime(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 20,
                  )),
            ),
          ],
        ),
        onPressed: () async {
          InputHelper.showBottomInput(
              context,
              'ETH address or ENS',
              Get.find<WatchlistController>().addressController,
              Get.find<WatchlistController>().onSubmit);
        },
      ),
    ));
  }
}

class _TimelineItem extends StatelessWidget {
  final Token token;

  const _TimelineItem({Key? key, required this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatchlistController>(
      builder: (c) => InkWell(
        onLongPress: () {},
        onTap: () async {
          await Get.toNamed(
            '/poap/${token.tokenId}',
            arguments: token,
          );
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
