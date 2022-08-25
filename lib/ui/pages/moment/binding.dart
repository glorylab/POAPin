import 'package:get/get.dart';
import 'package:poapin/ui/pages/moment/controller.dart';

class MomentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MomentController());
  }
}
