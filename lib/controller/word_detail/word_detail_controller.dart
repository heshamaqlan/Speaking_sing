import 'package:get/get.dart';

class WordDetailController extends GetxController {
  var isPlaying = false.obs;

  void togglePlay() {
    isPlaying.value = !isPlaying.value;
  }
}
