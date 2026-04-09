import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';
import 'package:speaking_sign/controller/onboarding/onbording_controller.dart';
import 'package:speaking_sign/data/static/static.dart';

class Customcontrolls extends StatelessWidget {
  const Customcontrolls({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final controller = Get.find<OnboardingController>();

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          onbordinglist.length,
          (index) => AnimatedContainer(
            margin: const EdgeInsets.only(right: 5),
            duration: const Duration(milliseconds: 300),
            width: controller.currentPage.value == index ? 24 : 8,
            height: 8,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Color(0xff8B3DFF),
            ),
          ),
        ),
      ),
    );
  }
}
