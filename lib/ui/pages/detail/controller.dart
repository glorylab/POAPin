import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/controllers/tag.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/data/repository/gitpoap_repository.dart';
import 'package:poapin/data/repository/poap_repository.dart';
import 'package:poapin/data/repository/welook_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/detail/dialog/addtag.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as img;
import 'package:blurhash_dart/blurhash_dart.dart' as dart_blur;
import 'package:share_plus/share_plus.dart';
import 'package:we_slide/we_slide.dart';

class DetailController extends BaseController {
  @override
  String screenName() {
    return 'POAP Detail';
  }

  final TextEditingController textEditController = TextEditingController();

  final tokensRepository = getIt.get<POAPRepository>();
  final gitPOAPRepository = getIt.get<GitPOAPRepository>();
  final welookRepository = getIt.get<WelookRepository>();

  final tokenID = ''.obs;
  final error = ''.obs;
  final blurBackground = Uint8List(0).obs;
  final status = LoadingStatus.loading.obs;
  final token = Token.empty().obs;

  final times = <Map<String, String>>[].obs;

  final slideController = WeSlideController();

  // final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  List<double>? gyroscopeValues;

  bool isFromCollection = false;
  bool isRound = false;

  bool isGitPOAP = false;
  int gitPOAPID = -1;

  int momentsCount = 0;

  updateID(String? id) {
    tokenID.value = id!;
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

    if (arguments != null && arguments is Token) {
      token.value = arguments;
      tokenID.value = token.value.tokenId;
      isFromCollection = true;
      status.value = LoadingStatus.loaded;
    }
    updateID(parameters['id']);
    Get.find<TagController>().refreshTag([token.value.event.id]);
    getData();
    checkIsGitPOAP();
    getMoments();
    _initGyroscope();
  }

  void _initGyroscope() {}

  void addTag() {
    Get.dialog(
      AddTagDialog(
        events: [token.value.event],
        textEditController: textEditController,
      ),
    );
  }

  String getEventLocation() {
    if (token.value.event.country == null) {
      return '';
    }
    String country;
    String city = '';
    if (token.value.event.country!.isNotEmpty) {
      country = token.value.event.country!;

      if (token.value.event.city != null &&
          token.value.event.city!.isNotEmpty) {
        city = token.value.event.city!;
        return '$city, $country';
      } else {
        return country;
      }
    }
    return '';
  }

  void captureBG() async {
    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(token.value.event.imageUrl))
                .load(token.value.event.imageUrl))
            .buffer
            .asUint8List();
    final image = img.Image.fromBytes(20, 20, bytes.toList());
    final blurHash = dart_blur.BlurHash.encode(image, numCompX: 3, numCompY: 4);

    final backgroundImage =
        dart_blur.BlurHash.decode(blurHash.hash).toImage(10, 10);
    blurBackground.value = Uint8List.fromList(encodeJpg(backgroundImage));
  }

  void checkIsGitPOAP() async {
    var response = await gitPOAPRepository.isEventGitPOAP(token.value.event.id);
    isGitPOAP = response['isGitPOAP'];
    gitPOAPID = response['gitPOAPID'] ?? -1;
    update();
  }

  void launchGitPOAP(int gitPOAPID) {
    if (gitPOAPID > 0) {
      launchURL('https://www.gitpoap.io/gp/$gitPOAPID');
    }
  }

  void getMoments() async {
    var response = await welookRepository.count(token.value.event.id);
    momentsCount = response;
    update();
  }

  void getData() async {
    if (tokenID.value == '') {
      return;
    }
    if (!isFromCollection) {
      status.value = LoadingStatus.loading;
    }
    var response = await tokensRepository.getToken(tokenID.value);
    token.value = response;
    refreshOrder();
    refreshTotal();
    Get.find<TagController>().refreshTag([token.value.event.id]);
    token.value.event.tags =
        Get.find<TagController>().tagsInEvents[token.value.event.id];
    status.value = LoadingStatus.loaded;
  }

  String order = '-';
  String total = '-';

  void refreshOrder() {
    if (token.value.supply?.order != null) {
      order = token.value.supply!.order.toString();
      update();
    }
  }

  void refreshTotal() {
    if (token.value.supply?.total != null) {
      total = token.value.supply!.total.toString();
      update();
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
        return Jiffy(token.value.event.startDate).yMMMd;
      case 1:
        if (token.value.event.startDate!
            .isAtSameMomentAs(token.value.event.endDate!)) {
          return "";
        }
        return Jiffy(token.value.event.endDate).yMMMd;
      case 2:
        return Jiffy(token.value.event.expiryDate).yMMMd;
      default:
        return "-";
    }
  }
}
