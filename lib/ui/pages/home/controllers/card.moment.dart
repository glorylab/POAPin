import 'package:get/get.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/data/repository/welook_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/home/components/dialog.moment.dart';

class MomentsCardController extends BaseController {
  int momentCount = 0;
  bool isLoading = true;
  bool isError = false;
  Moment previewMoment = Moment.empty();

  final welookRepository = getIt.get<WelookRepository>();

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

  getFirstMoment(String address) {
    previewMoment = Moment.empty();
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

  void showMomentsDialog() {
    Get.dialog(const MomentDialog());
  }

  void launchWelook(String address) {
    launchURL('welook.io', '$address/poap');
  }

  @override
  String screenName() {
    return 'MomentsCard';
  }
}
