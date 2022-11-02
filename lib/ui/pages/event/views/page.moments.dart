import 'package:dismissible_page/dismissible_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/components/loading.dart';
import 'package:poapin/ui/pages/event/controller.dart';
import 'package:poapin/ui/pages/moment/page.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MomentsInEventPage extends StatelessWidget {
  const MomentsInEventPage({Key? key}) : super(key: key);

  Widget _buildPreviewImage(Moment moment, String? url, BuildContext context) {
    if (url != null) {
      return GestureDetector(
        onTap: () {
          context.pushTransparentRoute(
            MomentPage(
              moment: moment,
            ),
          );
        },
        child: Hero(
          tag: 'moment_${moment.momentId}',
          child: ExtendedImage.network(
            url,
            clipBehavior: Clip.hardEdge,
            cache: true,
            key: Key('moment_${moment.momentId}'),
            enableLoadState: true,
            clearMemoryCacheWhenDispose: false,
            compressionRatio: 0.6,
            maxBytes: 200 << 10,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
      color: PColor.background,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 200).floor();
    double safePaddingLeft = MediaQuery.of(context).padding.left;
    double safePaddingRight = MediaQuery.of(context).padding.right;
    return Container(
      color: PColor.background,
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 0,
          right: 0,
          bottom: 0),
      child: GetBuilder<EventDetailController>(
        builder: (c) => c.isLoadingAllMoments
            ? ListView(
                children: const [
                  SizedBox(height: 256 + 32),
                  LoadingAnimation(),
                ],
              )
            : c.momentCount == 0
                ? ListView(
                    children: [
                      const SizedBox(height: 256 + 32),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              width: double.infinity,
                              child: Image.asset(
                                'icons/ic_moments.png',
                                package: 'web3_icons',
                                height: 18,
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              strMomentsDesc,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 16),
                            RawMaterialButton(
                              onPressed: () {
                                c.launchWelook(c.eventID);
                              },
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              fillColor: PColor.welook,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Text(
                                  strUploadMoments,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus? mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text("pull up to load",
                              style: TextStyle(color: Colors.grey[400]));
                        } else if (mode == LoadStatus.noMore) {
                          body = Text("All moments loaded",
                              style: TextStyle(color: Colors.grey[400]));
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = Text("Load Failed! Tap to retry!",
                              style: TextStyle(color: Colors.grey[400]));
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text("release to load more",
                              style: TextStyle(color: Colors.grey[400]));
                        } else {
                          body = Text("No more Data",
                              style: TextStyle(color: Colors.grey[400]));
                        }
                        return SizedBox(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: c.refreshController,
                    onLoading: c.onLoading,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            height: 256 + 32,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: const [0.0, 1.0],
                                    colors: [PColor.background, Colors.white])),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(
                            left: 16 + safePaddingLeft,
                            right: 16 + safePaddingRight,
                            top: 12,
                            bottom: 12,
                          ),
                          sliver: SliverMasonryGrid.count(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childCount: c.moments.length,
                            itemBuilder: (context, index) {
                              if (c.isLoadingAllMoments && index == 1) {
                                return const SizedBox(
                                  height: 128,
                                  child: Align(
                                    child: SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1),
                                    ),
                                  ),
                                );
                              }
                              return Card(
                                elevation: 8,
                                shadowColor: Colors.blueGrey.withOpacity(0.2),
                                clipBehavior: Clip.antiAlias,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: SizedBox(
                                  width: 100,
                                  child: Column(
                                    children: [
                                      _buildPreviewImage(
                                          c.moments[index],
                                          c.getPreviewImageURL(
                                              c.moments[index]),
                                          context),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
