import 'package:get/get.dart';
import 'package:poapin/ui/pages/dashboard/controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
