import 'package:flutter/material.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';
import 'package:speaking_sign/presentation/screens/transulate/custom_model_view.dart';

class TransulateView extends StatelessWidget {
  const TransulateView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: colors.scaffoldBackground,
      body: CustomModelView(),
    );
  }
}
