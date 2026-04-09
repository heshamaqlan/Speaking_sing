import 'package:get/get.dart';
import 'package:speaking_sign/controller/keyboard/keboard_controller.dart';

class KeyboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<KeyboardController>(KeyboardController());
  }
}
