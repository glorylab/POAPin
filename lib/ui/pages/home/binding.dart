import 'package:get/get.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
