import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/components/buttons/back.dart';
import 'package:poapin/ui/components/buttons/go_home.dart';
import 'package:poapin/ui/pages/moments/controller.dart';

class MomentsPage extends StatelessWidget {
  const MomentsPage({Key? key}) : super(key: key);

  Widget _buildPreviewImage(String? url) {
    if (url != null) {
      return ExtendedImage.network(
        url,
        clipBehavior: Clip.hardEdge,
        cache: true,
        enableLoadState: false,
        clearMemoryCacheWhenDispose: true,
        compressionRatio: 0.6,
        maxBytes: 200 << 10,
        fit: BoxFit.cover,
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
    return Scaffold(
      appBar: AppBar(
        leading: Get.previousRoute == ''
            ? const GoHomeButton()
            : const GoBackButton(),
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'icons/ic_moments.png',
          package: 'web3_icons',
          height: 18,
        ),
      ),
      body: GetBuilder<MomentsController>(
        builder: (c) => MasonryGridView.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          addAutomaticKeepAlives: true,
          cacheExtent: 100000,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: c.itemCount,
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
                      _buildPreviewImage(c.getPreviewImageURL(c.previewMoment)),
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
                    _buildPreviewImage(c.getPreviewImageURL(c.moments[index])),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
