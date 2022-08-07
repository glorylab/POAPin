import 'package:get/get.dart';
import 'package:poapin/ui/pages/event/controller.dart';

class EventDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventDetailController());
  }
}
