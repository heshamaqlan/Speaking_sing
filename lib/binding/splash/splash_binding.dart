import 'package:get/get.dart';
import 'package:speaking_sign/controller/splash/splash_controoler.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
