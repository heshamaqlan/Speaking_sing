import 'package:flutter/material.dart';
import 'package:speaking_sign/presentation/widgets/onboarding/custombutton.dart';
import 'package:speaking_sign/presentation/widgets/onboarding/customcontrolls.dart';
import 'package:speaking_sign/presentation/widgets/onboarding/customslider.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.04),

                Expanded(
                  flex: 10,
                  child: Customslider(pageController: _pageController),
                ),

                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      const Customcontrolls(),
                      const Spacer(),
                      Custombutton(pageController: _pageController),
                      SizedBox(height: constraints.maxHeight * 0.04),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
