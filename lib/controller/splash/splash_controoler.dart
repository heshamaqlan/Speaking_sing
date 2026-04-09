import 'package:get/get.dart';
import 'package:speaking_sign/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToOnboarding();
  }

  _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.offNamed(AppRoutes.ONBOARDING);
  }
}
