import 'package:get/get.dart';
import 'package:poapin/ui/pages/journal/controller.dart';

class JournalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JournalController());
  }
}
