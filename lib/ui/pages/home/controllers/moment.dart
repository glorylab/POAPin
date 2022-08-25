import 'package:get/get.dart';
import 'package:poapin/data/models/moment.dart';
import 'package:poapin/data/repository/welook_repository.dart';
import 'package:poapin/di/service_locator.dart';

class MomentController extends GetxController {
  int momentCount = 0;
  bool isLoading = true;
  bool isError = false;
  Moment previewMoment = Moment.empty();

  final welookRepository = getIt.get<WelookRepository>();

  getFirstMoment(String address) {
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
}
