import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/controller.base.dart';

class ArtworkController extends BaseController {
  @override
  String screenName() {
    return 'Artwork Page';
  }

  @override
  void onInit() {
    super.onInit();
    // ImageDownloader.callback(onProgressUpdate: (String? imageId, int progress) {
    //   if (progress == 100) {
    //     Get.snackbar(
    //         'Download Complete', 'POAP artwork has been saved to your gallery',
    //         messageText: Text(
    //           'POAP artwork has been saved to your gallery',
    //           style: GoogleFonts.roboto(color: Colors.lightGreen),
    //         ),
    //         duration: const Duration(seconds: 2),
    //         titleText: Text(
    //           'Download Complete',
    //           style: GoogleFonts.robotoSlab(
    //             color: Colors.green,
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20,
    //           ),
    //         ),
    //         animationDuration: const Duration(milliseconds: 200),
    //         snackPosition: SnackPosition.BOTTOM);
    //   }
    // });
  }

  savePOAPArtwork(String imageUrl) async {
    // if (Platform.isAndroid || Platform.isIOS) {
    //   if (imageUrl.isNotEmpty) {
    //     try {
    //       var imageId = await ImageDownloader.downloadImage(
    //         imageUrl,
    //         destination: AndroidDestinationType.directoryPictures,
    //       );
    //       if (imageId == null) {
    //         return;
    //       }
    //     } on PlatformException catch (error) {
    //       if (kDebugMode) {
    //         print(error);
    //       }
    //     }
    //   }
    // }
  }
}
