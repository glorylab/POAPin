import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:ens_dart/ens_dart.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/controllers/tag.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/data/repository/gitpoap_repository.dart';
import 'package:poapin/data/repository/poap_repository.dart';
import 'package:poapin/data/repository/welook_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/detail/dialog/addtag.dart';
import 'package:poapin/util/verification.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:we_slide/we_slide.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class DetailController extends BaseController {
  @override
  String screenName() {
    return 'POAP Detail';
  }

  PaletteGenerator paletteGenerator =
      PaletteGenerator.fromColors([PaletteColor(PColor.background, 1)]);
  Color backgroundColor = PColor.background;

  final TextEditingController textEditController = TextEditingController();

  final tokensRepository = getIt.get<POAPRepository>();
  final gitPOAPRepository = getIt.get<GitPOAPRepository>();
  final welookRepository = getIt.get<WelookRepository>();

  final tokenID = ''.obs;
  final error = ''.obs;
  final blurBackground = Uint8List(0).obs;
  final status = LoadingStatus.loading.obs;
  final token = Token.empty().obs;
  String ownerENS = '';

  final times = <Map<String, String>>[].obs;

  final slideController = WeSlideController();

  // final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  List<double>? gyroscopeValues;

  bool isFromCollection = false;
  bool isRound = true;

  bool isGitPOAP = false;
  int gitPOAPID = -1;

  bool isLoadingMomentsCount = true;
  int momentsCount = 0;
  bool isLoadingMoments = true;
  List<Moment> moments = <Moment>[];

  updateID(String? id) {
    tokenID.value = id!;
  }

  _updatePaletteGenerator() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(token.value.event.imageUrl));
    if (paletteGenerator.lightMutedColor != null) {
      backgroundColor = paletteGenerator.lightMutedColor!.color;
      update();
    }
  }

  String getSimpleAddress(String address) {
    if (address.length > 18) {
      return address.substring(0, 10) +
          '...' +
          address.substring(address.length - 4);
    }
    return address;
  }

  void _getOwnerENS() {
    VerificationHelper.getENSbyETH(ens, token.value.owner).then((value) {
      ownerENS = value;
      update();
    });
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
    final client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });
    ens = Ens(client: client);
    Get.put(TagController());
    final parameters = Get.parameters;
    final arguments = Get.arguments;
    if (parameters['id'] == null) {}

    if (arguments != null && arguments is Token) {
      token.value = arguments;
      tokenID.value = token.value.tokenId;
      isFromCollection = true;
      status.value = LoadingStatus.loaded;
      _getOwnerENS();
    }
    updateID(parameters['id']);
    Get.find<TagController>().refreshTag([token.value.event.id]);
    getData();
    _updatePaletteGenerator();
    checkIsGitPOAP();
    getMomentsCount();
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

  void launchWelook(int eventID) {
    if (eventID > 0) {
      launchURL('https://welook.io/moments/$eventID');
    }
  }

  void getMomentsCount() async {
    var response = await welookRepository.count(token.value.event.id);
    momentsCount = response;
    update();

    if (momentsCount > 0) {
      getPreviewMomentOfEvent();
    }
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

  Widget buildPreviewImage(String? url) {
    if (url != null) {
      return ExtendedImage.network(
        url,
        height: 88,
        clipBehavior: Clip.hardEdge,
        cache: true,
        enableLoadState: true,
        clearMemoryCacheWhenDispose: false,
        compressionRatio: 0.6,
        maxBytes: 200 << 10,
        fit: BoxFit.cover,
      );
    }
    return Container(
      color: PColor.background,
    );
  }

  getPreviewMomentOfEvent() {
    isLoadingMoments = true;
    update();
    welookRepository
        .getMomentsOfEvent(token.value.event.id)
        .then((MomentResponse momentResponse) {
      if (momentResponse.total != null) {
        if (momentResponse.moments != null &&
            momentResponse.moments!.isNotEmpty) {
          moments = momentResponse.moments!;
        }
      } else {
        moments = [];
      }
      isLoadingMoments = false;
      update();
    });
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
    _getOwnerENS();
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
