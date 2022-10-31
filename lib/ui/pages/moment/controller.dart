import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/data/repository/welook_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/ui/controller.base.dart';

class MomentController extends BaseController {
  int momentCount = 0;
  bool isLoading = true;
  bool isError = false;
  String address = '';

  final welookRepository = getIt.get<WelookRepository>();

  String getMomentTimeString(Moment moment) {
    return DateTime.parse(moment.publishDate)
        .toLocal()
        .toString()
        .substring(0, 16);
  }

  @override
  void onInit() {
    super.onInit();
    ImageDownloader.callback(onProgressUpdate: (String? imageId, int progress) {
      if (progress == 100) {
        Get.snackbar(
            'Download Complete', 'Moment has been saved to your gallery',
            messageText: Text(
              'Moment has been saved to your gallery',
              style: GoogleFonts.roboto(color: Colors.lightGreen),
            ),
            duration: const Duration(seconds: 2),
            titleText: Text(
              'Download Complete',
              style: GoogleFonts.robotoSlab(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            animationDuration: const Duration(milliseconds: 200),
            snackPosition: SnackPosition.BOTTOM);
      }
    });
  }

  String? getPreviewImageURL(Moment previewMoment) {
    if (previewMoment.bigImageUrl.isNotEmpty) {
      return previewMoment.bigImageUrl;
    } else if (previewMoment.smallImageUrl != null &&
        previewMoment.smallImageUrl!.isNotEmpty) {
      return previewMoment.smallImageUrl;
    } else if (previewMoment.originImageUrl != null &&
        previewMoment.originImageUrl!.isNotEmpty) {
      return previewMoment.originImageUrl;
    } else {
      return null;
    }
  }

  saveMomentPicture(Moment moment) async {
    if (Platform.isAndroid || Platform.isIOS) {
      if (getMomentOriginURL(moment).isNotEmpty) {
        try {
          var imageId = await ImageDownloader.downloadImage(
            getMomentOriginURL(moment),
            destination: AndroidDestinationType.directoryPictures,
          );
          if (imageId == null) {
            return;
          }
        } on PlatformException catch (error) {
          if (kDebugMode) {
            print(error);
          }
        }
      }
    }
  }

  String getMomentOriginURL(Moment moment) {
    if (moment.originImageUrl != null && moment.originImageUrl!.isNotEmpty) {
      return moment.originImageUrl!;
    } else if (moment.bigImageUrl.isNotEmpty) {
      return moment.bigImageUrl;
    } else if (moment.smallImageUrl != null &&
        moment.smallImageUrl!.isNotEmpty) {
      return moment.smallImageUrl!;
    }
    return '';
  }

  @override
  String screenName() {
    return 'Moment';
  }
}
