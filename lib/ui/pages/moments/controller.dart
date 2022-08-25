import 'package:poapin/data/models/moment.dart';
import 'package:poapin/data/repository/welook_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/ui/controller.base.dart';

class MomentsController extends BaseController {
  int momentCount = 0;
  bool isLoading = true;
  bool isLoadingAllMoments = true;
  bool isError = false;
  Moment previewMoment = Moment.empty();
  List<Moment> moments = [];

  final welookRepository = getIt.get<WelookRepository>();

  String? getPreviewImageURL(Moment previewMoment) {
    if (previewMoment.bigImageUrl.isNotEmpty) {
      return previewMoment.bigImageUrl;
    } else if (previewMoment.smallImageUrl.isNotEmpty) {
      return previewMoment.smallImageUrl;
    } else if (previewMoment.originImageUrl != null &&
        previewMoment.originImageUrl!.isNotEmpty) {
      return previewMoment.originImageUrl;
    } else {
      return null;
    }
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

  getAllMoments(String address) {
    print(address);
    isLoadingAllMoments = true;
    moments.clear();
    update();
    welookRepository
        .getMomentsOfAddress(address, limit: momentCount)
        .then((MomentResponse momentResponse) {
      if (momentResponse.total != null) {
        momentCount = momentResponse.total!;
        if (momentResponse.moments != null &&
            momentResponse.moments!.isNotEmpty) {
          moments = momentResponse.moments!;
        }
      } else {
        momentCount = 0;
        moments = [];
      }
      isLoadingAllMoments = false;
      update();
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
