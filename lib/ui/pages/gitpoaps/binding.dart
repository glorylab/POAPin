import 'package:get/get.dart';
import 'package:poapin/ui/pages/gitpoaps/controller.dart';

class GitPOAPsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GitPOAPsController());
  }
}
