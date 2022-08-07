import 'package:get/get.dart';
import 'package:poapin/ui/pages/square/controller.dart';

class SquareBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SquareController());
  }
}
