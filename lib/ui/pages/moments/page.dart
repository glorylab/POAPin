import 'package:dismissible_page/dismissible_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/components/buttons/back.dart';
import 'package:poapin/ui/components/buttons/go_home.dart';
import 'package:poapin/ui/pages/moment/page.dart';
import 'package:poapin/ui/pages/moments/controller.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MomentsPage extends StatelessWidget {
  const MomentsPage({Key? key}) : super(key: key);

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
    return Material(
      color: Colors.white,
      child: GetBuilder<MomentsController>(
        builder: (c) => Scrollbar(
          child: SmartRefresher(
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
                SliverAppBar(
                  expandedHeight: 120,
                  pinned: true,
                  leading: Get.previousRoute == ''
                      ? const GoHomeButton()
                      : const GoBackButton(),
                  automaticallyImplyLeading: true,
                  centerTitle: true,
                  elevation: 18,
                  shadowColor: PColor.welook.withOpacity(0.5),
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'icons/ic_moments.png',
                        package: 'web3_icons',
                        height: 18,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 30,
                        constraints: const BoxConstraints(minWidth: 32),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(30, 236, 72, 154),
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
                          c.isLoadingAllMoments ? '...' : '${c.momentCount}',
                          style: GoogleFonts.robotoMono(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 236, 72, 154),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  collapsedHeight: kToolbarHeight + 40,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 1.0],
                            colors: [PColor.welook, Colors.white]),
                      ),
                    ),
                    titlePadding: const EdgeInsets.only(
                        top: 16, bottom: 8, left: 16, right: 16),
                    title: Card(
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Text(
                          c.getENSorETH(c.previewMoment),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.robotoMono(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: PColor.welookDark.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
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
                    childCount: c.itemCount,
                    itemBuilder: (context, index) {
                      if (c.isLoadingAllMoments && index == 1) {
                        return const SizedBox(
                          height: 128,
                          child: Align(
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 1),
                            ),
                          ),
                        );
                      }
                      if (c.isLoadingAllMoments && index == 0) {
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
                                    c.previewMoment,
                                    c.getPreviewImageURL(c.previewMoment),
                                    context),
                              ],
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
                                  c.getPreviewImageURL(c.moments[index]),
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
      ),
    );
  }
}
