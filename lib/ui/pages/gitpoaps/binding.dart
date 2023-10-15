import 'package:get/get.dart';
import 'package:poapin/ui/pages/gitpoaps/controller.dart';

class GitPoapsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GitPoapsController());
  }
}
