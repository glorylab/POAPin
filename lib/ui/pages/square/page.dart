import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/ui/components/alerts/error.dart';
import 'package:poapin/ui/components/cache.image.dart';
import 'package:poapin/ui/components/card.note.dart';
import 'package:poapin/ui/components/loading.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/square/controller.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SquarePage extends BasePage {
  const SquarePage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        automaticallyImplyLeading: false,
        leading: null,
        // expandedHeight: 88,
        backgroundColor: Colors.white,
        title: Text(
          'Square',
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
      ),
      body: GetBuilder<SquareController>(
        builder: (c) {
          if (c.status == LoadingStatus.loading) {
            return const Center(
              child: LoadingAnimation(),
            );
          }
          if (c.status == LoadingStatus.failed) {
            return Center(
              child: ErrorBoard(
                text: c.error,
              ),
            );
          }
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("release to load more");
                } else {
                  body = const Text("No more Data");
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: c.refreshController,
            onRefresh: c.onRefresh,
            onLoading: c.onLoading,
            child: ListView.builder(
              controller: c.scrollController,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  if (c.isNoticeRead) {
                    return Container(
                      height: 16,
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 12 + getHorizontalPadding(context),
                        right: 12 + getHorizontalPadding(context),
                        bottom: 16,
                        top: 8),
                    child: NoteCard(
                      content:
                          'Here are the public events that just applied. You can view it when you feel bored. \nIf you are interested in attending various events, you can turn on notification push in the settings.\nKeep in mind that not all events are finally approved.',
                      ok: true,
                      onOkTap: () {
                        c.markAsRead();
                      },
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontalPadding(context)),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          '/event/' + c.events[index - 1].id.toString(),
                          arguments: {
                            'event': c.events[index - 1],
                          },
                        );
                      },
                      child: SizedBox(
                        height: 88,
                        child: Row(
                          children: [
                            Container(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.1),
                              child: CacheImage(
                                  url: c.events[index - 1].imageUrl, size: 88),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 16, top: 2, bottom: 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        c.events[index - 1].name,
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
                                          c.events[index - 1].description,
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
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
                            ),
                          ],
                        ),
                        //
                      ),
                    ),
                  ),
                );
              },
              itemCount: c.events.length + 1,
            ),
          );
        },
      ),
    );
  }
}
