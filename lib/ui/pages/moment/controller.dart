import 'package:poapin/data/models/moment.dart';
import 'package:poapin/data/repository/welook_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/ui/controller.base.dart';

class MomentController extends BaseController {
  int momentCount = 0;
  bool isLoading = true;
  bool isError = false;
  Moment moment = Moment.empty();
  String address = '';

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

  // _getData() {
  //   final arguments = Get.arguments;
  //   if (arguments != null && arguments['moment'] != null) {
  //     moment = arguments['moment'] as Moment;
  //     address = moment.authorAddress;
  //     update();
  //   }
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   // _getData();
  // }

  @override
  String screenName() {
    return 'Moment';
  }
}
