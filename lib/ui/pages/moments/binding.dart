import 'package:get/get.dart';
import 'package:poapin/ui/pages/moments/controller.dart';

class MomentsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MomentsController());
  }
}
