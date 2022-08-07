import 'package:get/get.dart';
import 'package:poapin/ui/pages/tags/controller.dart';

class TagsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TagsController());
  }
}
