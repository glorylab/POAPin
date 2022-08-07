import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/controllers/tag.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/data/repository/poap_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/detail/dialog/addtag.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as img;
import 'package:blurhash_dart/blurhash_dart.dart' as dart_blur;
import 'package:share_plus/share_plus.dart';
import 'package:we_slide/we_slide.dart';

class EventDetailController extends BaseController {
  @override
  String screenName() {
    return 'Event Detail';
  }

  final POAPRepository poapRepository = getIt.get<POAPRepository>();

  final TextEditingController textEditController = TextEditingController();

  int eventID = 0;
  final error = ''.obs;
  final blurBackground = Uint8List(0).obs;
  final status = LoadingStatus.loading.obs;
  Event event = Event.empty();

  final times = <Map<String, String>>[].obs;

  final slideController = WeSlideController();

  bool isFromCollection = false;
  bool isRound = false;

  updateID(int id) {
    eventID = id;
    update();
  }

  toggleShape() {
    isRound = !isRound;
    update();
  }

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  File? imagePath;
  Future share() {
    return screenshotController.capture().then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        imagePath = await File('${directory.path}/image.png').create();
      }
      await imagePath!.writeAsBytes(image!);
      await Share.shareFiles([imagePath!.path], mimeTypes: ['image/png']);
      return;
    });
  }

  @override
  void onInit() {
    super.onInit();
    Get.put(TagController());
    final parameters = Get.parameters;
    final arguments = Get.arguments;
    if (parameters['id'] == null) {}

    if (arguments != null && arguments is Event) {
      event = arguments;
      eventID = event.id;
      isFromCollection = true;
      status.value = LoadingStatus.loaded;
    }
    updateID(int.parse(parameters['id']!));
    getData();
  }

  void addTag() {
    Get.dialog(
      AddTagDialog(
        events: [event],
        textEditController: textEditController,
      ),
    );
  }

  String getEventLocation() {
    if (event.country == null) {
      return '';
    }
    String country;
    String city = '';
    if (event.country!.isNotEmpty) {
      country = event.country!;

      if (event.city != null && event.city!.isNotEmpty) {
        city = event.city!;
        return '$city, $country';
      } else {
        return country;
      }
    }
    return '';
  }

  void captureBG() async {
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(event.imageUrl))
            .load(event.imageUrl))
        .buffer
        .asUint8List();
    final image = img.Image.fromBytes(20, 20, bytes.toList());
    final blurHash = dart_blur.BlurHash.encode(image, numCompX: 3, numCompY: 4);

    final backgroundImage =
        dart_blur.BlurHash.decode(blurHash.hash).toImage(10, 10);
    blurBackground.value = Uint8List.fromList(encodeJpg(backgroundImage));
  }

  void getData() async {
    if (eventID == 0) {
      return;
    }
    if (!isFromCollection) {
      status.value = LoadingStatus.loading;
    }
    try {
      var response = await Dio().get('https://api.poap.in/event/$eventID');
      error.value = '';
      var _res = response.data;

      if (_res['code'] == 0) {
        event = Event.fromJson(_res['data']);
        update();
      }

      Get.find<TagController>().refreshTag([event.id]);
      event.tags = Get.find<TagController>().tagsInEvents[event.id];
      status.value = LoadingStatus.loaded;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data != null && e.response!.data['message'] != null) {
          status.value = LoadingStatus.failed;
          error.value = e.response!.data['message'];
        }
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        error.value = 'Oops, something went wrong';
        status.value = LoadingStatus.loaded;
      }
    }
  }

  String getTimelineTitle(int index) {
    switch (index) {
      case 0:
        return "Start Date";
      case 1:
        return "End Date";
      case 2:
        return "Expiry Date";
      default:
        return "-";
    }
  }

  String? getTimelineContent(int index) {
    switch (index) {
      case 0:
        return Jiffy(event.startDate).yMMMd;
      case 1:
        if (event.startDate!.isAtSameMomentAs(event.endDate!)) {
          return "";
        }
        return Jiffy(event.endDate).yMMMd;
      case 2:
        return Jiffy(event.expiryDate).yMMMd;
      default:
        return "-";
    }
  }
}
