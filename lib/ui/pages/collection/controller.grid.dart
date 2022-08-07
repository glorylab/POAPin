import 'package:get/get.dart';

class CollectionGridController extends GetxController {
  final clip = 'square'.obs;

  toggleClip() {
    if (clip.value == 'square') {
      clip.value = 'circle';
    } else {
      clip.value = 'square';
    }
  }
}
