import 'package:get/get.dart';
import 'package:speaking_sign/controller/keyboard/key_controller.dart';
import 'package:speaking_sign/controller/keyboard/keboard_controller.dart';
import 'package:speaking_sign/controller/onboarding/onbording_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<KeyController>(KeyController());
    Get.put(KeyboardController());
  }
}
