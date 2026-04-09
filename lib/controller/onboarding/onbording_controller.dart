import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final RxInt currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  bool next(int totalPages) {
    final nextIndex = currentPage.value + 1;

    if (nextIndex >= totalPages) {
      return true;
    }

    currentPage.value = nextIndex;
    return false;
  }
}
