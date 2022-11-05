import 'package:dismissible_page/dismissible_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/ui/page.base.transparent.dart';
import 'package:poapin/ui/pages/artwork/controller.dart';
import 'package:poapin/ui/pages/event/controller.dart';

class ArtworkPage extends BaseTransparentPage<ArtworkController> {
  const ArtworkPage({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.down,
      isFullScreen: true,
      child: Stack(children: [
        Center(
          child: Hero(
            tag: imageUrl,
            child: ExtendedImage.network(
              imageUrl,
              clipBehavior: Clip.hardEdge,
              cache: true,
              key: Key(imageUrl),
              enableLoadState: true,
              clearMemoryCacheWhenDispose: false,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BottomSheet(
            imageUrl: imageUrl,
          ),
        ),
      ]),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    child: Container(),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {
                    Get.find<ArtworkController>().savePOAPArtwork(imageUrl);
                  },
                  elevation: 1.0,
                  fillColor: Colors.white12,
                  child: const Icon(
                    Icons.download_rounded,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(24.0),
                  shape: const CircleBorder(),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
