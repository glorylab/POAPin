import 'package:get/get.dart';
import 'package:poapin/ui/pages/me/controller.dart';

class MeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MeController());
  }
}
