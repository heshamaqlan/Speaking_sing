import 'package:get/get.dart';
import 'package:speaking_sign/controller/settings/settings_controller.dart';

class AbpoutViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController());
  }
}
