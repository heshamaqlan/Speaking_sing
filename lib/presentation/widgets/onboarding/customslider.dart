import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';
import 'package:speaking_sign/controller/onboarding/onbording_controller.dart';
import 'package:speaking_sign/data/static/static.dart';

class Customslider extends StatelessWidget {
  final PageController pageController;

  const Customslider({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final controller = Get.find<OnboardingController>();

    return PageView.builder(
      controller: pageController,
      onPageChanged: (value) {
        controller.onPageChanged(value);
      },
      itemCount: onbordinglist.length,
      itemBuilder:
          (context, i) => LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;

              return Column(
                children: [
                  Container(
                    height: h * 0.60,
                    width: w * 0.9,
                    alignment: Alignment.center,
                    child: Image.asset(
                      onbordinglist[i].image!,
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: h * 0.05),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                    child: Text(
                      onbordinglist[i].title!,
                      style: TextStyle(
                        fontSize: (w * 0.06).clamp(20.0, 32.0),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                    alignment: Alignment.center,
                    child: Text(
                      onbordinglist[i].body!,
                      style: TextStyle(
                        fontSize: (w * 0.04).clamp(14.0, 22.0),
                        color: Colors.grey,
                        fontFamily: "Cairo",
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }
          ),
    );
  }
}
