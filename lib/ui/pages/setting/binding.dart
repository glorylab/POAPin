import 'package:get/get.dart';
import 'package:poapin/ui/pages/setting/controller.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}
