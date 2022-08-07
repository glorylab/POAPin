import 'package:get/get.dart';
import 'package:poapin/ui/pages/detail/controller.dart';

class DetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailController());
  }
}
