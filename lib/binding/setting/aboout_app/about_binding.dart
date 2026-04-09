import 'package:get/get.dart';
import 'package:speaking_sign/controller/settings/about_app/about_controller.dart';

class AbpoutViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AboutController>(AboutController());
  }
}
