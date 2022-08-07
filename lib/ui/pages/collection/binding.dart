import 'package:get/get.dart';
import 'package:poapin/ui/pages/collection/controller.dart';

class CollectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollectionController());
  }
}
