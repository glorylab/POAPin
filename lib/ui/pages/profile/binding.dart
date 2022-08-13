import 'package:get/get.dart';
import 'package:poapin/ui/pages/profile/controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
