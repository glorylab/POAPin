import 'package:dismissible_page/dismissible_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/ui/components/buttons/back.dart';
import 'package:poapin/ui/components/buttons/go_home.dart';
import 'package:poapin/ui/page.base.dart';
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
      direction: DismissiblePageDismissDirection.multi,
      isFullScreen: true,
      child: Center(
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
    );
  }
}
