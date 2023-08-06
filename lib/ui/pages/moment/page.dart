import 'package:dismissible_page/dismissible_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/ui/page.base.transparent.dart';
import 'package:poapin/ui/pages/moment/controller.dart';

class MomentPage extends BaseTransparentPage<MomentController> {
  const MomentPage({Key? key, required this.moment}) : super(key: key);

  final Moment moment;

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
            tag: 'moment_${moment.momentId}',
            child: ExtendedImage.network(
              controller.getPreviewImageURL(moment)!,
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
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BottomSheet(
            moment: moment,
          ),
        ),
      ]),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({Key? key, required this.moment}) : super(key: key);

  final Moment moment;

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
                RawMaterialButton(
                  onPressed: () {
                    Get.toNamed(
                      '/event/${moment.poapEventID}',
                      arguments: {
                        'page': 'moments',
                      },
                    );
                  },
                  elevation: 1.0,
                  fillColor: Colors.white12,
                  padding: const EdgeInsets.all(12.0),
                  shape: const CircleBorder(),
                  child: Image.asset(
                    'icons/ic_poap.png',
                    package: 'web3_icons',
                    height: 48,
                    width: 48,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    child: Text(
                      Get.find<MomentController>().getMomentTimeString(moment),
                      style: GoogleFonts.robotoMono(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {
                    Get.find<MomentController>().saveMomentPicture(moment);
                  },
                  elevation: 1.0,
                  fillColor: Colors.white12,
                  padding: const EdgeInsets.all(24.0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.download_rounded,
                    size: 24.0,
                    color: Colors.white,
                  ),
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
