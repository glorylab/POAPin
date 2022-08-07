import 'package:get/get.dart';
import 'package:poapin/ui/pages/auth/controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
