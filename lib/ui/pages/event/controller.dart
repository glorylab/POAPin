import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:jiffy/jiffy.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/controllers/tag.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/data/repository/poap_repository.dart';
import 'package:poapin/data/repository/welook_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/detail/dialog/addtag.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:we_slide/we_slide.dart';

class EventDetailController extends BaseController {
  @override
  String screenName() {
    return 'Event Detail';
  }

  PaletteGenerator paletteGenerator =
      PaletteGenerator.fromColors([PaletteColor(PColor.background, 1)]);
  Color backgroundColor = PColor.background;

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
  bool isRound = true;

  final PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int currentPageIndex = 0;

  /// Moments -------------------------------------------------------------Start
  final welookRepository = getIt.get<WelookRepository>();
  List<Moment> moments = [];

  int momentCount = 0;

  bool isLoadingAllMoments = true;

  int offset = 0;
  int limit = 20;
  String sort = 'desc';
  bool isAllDataLoaded = false;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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

  String getENSorETH(Moment moment) {
    if (moment.authorENS != null && moment.authorENS!.isNotEmpty) {
      return moment.authorENS!;
    } else if (moment.authorAddress.isNotEmpty) {
      return getSimpleAddress(moment.authorAddress);
    } else {
      return '-';
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

  _getMoments() {
    isLoadingAllMoments = true;
    if (offset == 0) {
      moments.clear();
      update();
    }
    if (isAllDataLoaded) {
      return;
    }

    welookRepository
        .getMomentsOfEvent(
      eventID,
      limit: limit,
      sort: sort,
      offset: offset,
    )
        .then((MomentResponse momentResponse) {
      offset = limit + offset;
      if (momentResponse.total != null) {
        momentCount = momentResponse.total!;
        if (momentResponse.moments != null &&
            momentResponse.moments!.isNotEmpty) {
          moments.addAll(momentResponse.moments!);
        }
        if (momentResponse.moments!.isEmpty) {
          isAllDataLoaded = true;
        }
      } else {
        if (momentCount == 0) {
          momentCount = 0;
          moments = [];
        }
        isAllDataLoaded = true;
      }
      isLoadingAllMoments = false;
      update();
      if (isAllDataLoaded) {
        refreshController.loadNoData();
      }
    });
  }

  savePOAPArtwork(Event event) async {
    if (Platform.isAndroid || Platform.isIOS) {
      if (event.imageUrl.isNotEmpty) {
        try {
          var imageId = await ImageDownloader.downloadImage(
            event.imageUrl,
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

  void onLoading() async {
    if (isLoadingAllMoments) return;
    await _getMoments();
    refreshController.loadComplete();
  }

  void launchWelook(int eventID) {
    launchURL('https://welook.io/moments/$eventID');
  }

  /// Moments ---------------------------------------------------------------End

  updateID(int id) {
    eventID = id;
    update();
  }

  toggleShape() {
    isRound = !isRound;
    update();
  }

  _updatePaletteGenerator() async {
    paletteGenerator =
        await PaletteGenerator.fromImageProvider(NetworkImage(event.imageUrl));
    if (paletteGenerator.lightVibrantColor != null) {
      backgroundColor = paletteGenerator.lightVibrantColor!.color;
      update();
    }
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

    if (arguments != null &&
        arguments['event'] != null &&
        arguments['event'] is Event) {
      event = arguments['event'];
      eventID = event.id;
      isFromCollection = true;
      status.value = LoadingStatus.loaded;
    }

    if (arguments != null &&
        arguments['page'] != null &&
        arguments['page'] is String) {
      if (arguments['page'] == 'moments') {
        currentPageIndex = 1;
        update();
        Future.delayed(const Duration(milliseconds: 300), () {
          pageController.animateToPage(1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
          update();
        });
      }
    }

    updateID(int.parse(parameters['id']!));
    getData();
    _updatePaletteGenerator();

    refreshController = RefreshController(
      initialRefresh: false,
      initialRefreshStatus: RefreshStatus.idle,
    );
    _getMoments();

    pageController.addListener(() {
      currentPageIndex = pageController.page!.round();
      update();
    });

    ImageDownloader.callback(onProgressUpdate: (String? imageId, int progress) {
      if (progress == 100) {
        Get.snackbar(
            'Download Complete', 'POAP artwork has been saved to your gallery',
            messageText: Text(
              'POAP artwork has been saved to your gallery',
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

  void jumpToPage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic);
    update();
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

  void getData() async {
    if (eventID == 0) {
      return;
    }
    if (!isFromCollection) {
      status.value = LoadingStatus.loading;
    }

    poapRepository.getEventDetail(eventID).then((Event responseEvent) {
      if (responseEvent.id > 0) {
        event = responseEvent;
        status.value = LoadingStatus.loaded;
        update();
        Get.find<TagController>().refreshTag([event.id]);
        event.tags = Get.find<TagController>().tagsInEvents[event.id];
        status.value = LoadingStatus.loaded;
      }
    }).catchError((error) {
      status.value = LoadingStatus.failed;
      error.value = 'Oops, something went wrong';
      update();
    });
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
