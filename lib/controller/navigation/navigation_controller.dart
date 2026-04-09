import 'package:get/get.dart';

class NavigationController extends GetxController {
  var currentIndex = 2.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
