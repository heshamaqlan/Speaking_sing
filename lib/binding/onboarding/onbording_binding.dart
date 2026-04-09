import 'package:get/get.dart';
import 'package:speaking_sign/controller/onboarding/onbording_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnboardingController>(OnboardingController());
  }
}
