import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';
import 'package:speaking_sign/controller/onboarding/onbording_controller.dart';
import 'package:speaking_sign/data/static/static.dart';
import 'package:speaking_sign/routes/app_routes.dart';

class Custombutton extends StatelessWidget {
  final PageController? pageController;

  const Custombutton({super.key, this.pageController});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final controller = Get.find<OnboardingController>();
    final screenWidth = MediaQuery.sizeOf(context).width;
    final buttonWidth = (screenWidth * 0.8).clamp(200.0, 400.0);

    return SizedBox(
      width: buttonWidth,
      child: MaterialButton(
        textColor: Colors.white,
        onPressed: () {
          final isFinished = controller.next(onbordinglist.length);

          if (isFinished) {
            Get.offAllNamed(AppRoutes.CustomCurvedBottomNavigationBar);
          } else {
            final nextIndex = controller.currentPage.value;

            pageController?.animateToPage(
              nextIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        color: const Color(0xff8B3DFF),
        padding: const EdgeInsets.symmetric(vertical: 15),
        elevation: 5,
        child: Text(
          "استمـــرار",
          style: TextStyle(
            fontSize: (screenWidth * 0.045).clamp(16.0, 22.0),
            fontWeight: FontWeight.bold,
            fontFamily: "Cairo",
          ),
        ),
      ),
    );
  }
}
