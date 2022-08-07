import 'package:get/get.dart';
import 'package:poapin/ui/pages/app/controller.dart';

class APPBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => APPController());
  }
}
