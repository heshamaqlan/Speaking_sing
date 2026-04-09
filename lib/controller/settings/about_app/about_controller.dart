import 'package:get/get.dart';

class AboutController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToSetting();
  }

  void navigateToSetting() {
    Get.back();
  }
}
