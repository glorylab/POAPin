import 'package:get/get.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/data/repository/welook_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MomentsController extends BaseController {
  int momentCount = 0;
  bool isLoading = true;
  bool isLoadingAllMoments = true;
  bool isError = false;
  Moment previewMoment = Moment.empty();
  List<Moment> moments = [];

  String address = '';

  final welookRepository = getIt.get<WelookRepository>();

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
      return '${address.substring(0, 10)}...${address.substring(address.length - 4)}';
    }
    return address;
  }

  _getData() {
    final arguments = Get.arguments;
    if (arguments != null && arguments['preview'] != null) {
      previewMoment = arguments['preview'] as Moment;
      address = previewMoment.authorAddress;
      update();
      getMoments();
    } else {
      isLoadingAllMoments = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(
      initialRefresh: false,
      initialRefreshStatus: RefreshStatus.idle,
    );
    _getData();
  }

  void onLoading() async {
    if (isLoadingAllMoments) return;
    await getMoments();
    refreshController.loadComplete();
  }

  int get itemCount {
    int itemCount;
    itemCount = isLoadingAllMoments
        ? 2
        : moments.isNotEmpty
            ? moments.length
            : 1;
    return itemCount;
  }

  getMoments() {
    isLoadingAllMoments = true;
    if (offset == 0) {
      moments.clear();
      update();
    }
    if (isAllDataLoaded) {
      return;
    }

    welookRepository
        .getMomentsOfAddress(
      address,
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

  getFirstMoment(String address) {
    moments.clear();
    previewMoment = Moment.empty();
    isLoadingAllMoments = true;
    isLoading = true;
    momentCount = 0;
    update();
    welookRepository
        .getMomentsOfAddress(address)
        .then((MomentResponse momentResponse) {
      if (momentResponse.total != null) {
        momentCount = momentResponse.total!;
        if (momentResponse.moments != null &&
            momentResponse.moments!.isNotEmpty) {
          previewMoment = momentResponse.moments!.first;
        }
      } else {
        momentCount = 0;
        previewMoment = Moment.empty();
      }
      isLoading = false;
      update();
    });
  }

  @override
  String screenName() {
    return 'Moments';
  }
}
