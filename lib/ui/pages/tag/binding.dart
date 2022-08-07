import 'package:get/get.dart';
import 'package:poapin/ui/pages/tag/controller.dart';

class TagBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TagDetailController());
  }
}
