import 'package:get/get.dart';
import 'package:poapin/ui/pages/watchlist/controller.dart';

class WatchlistBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WatchlistController());
  }
}
