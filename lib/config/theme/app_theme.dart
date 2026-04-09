import 'package:flutter/material.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Cairo',
    extensions: [
      AppColors(
        scaffoldBackground: Color(0xffffffff),
        navigaionBar: Color(0xffe2eafc),
        wordCard: Color(0xfff4f5f7),
        wordCardText: Color(0xff000000),
        wordCardIcon: Color(0xff8B3DFF),
        cardShadow: Colors.black12,
        settingCardIcon: Color(0xff052a3a),
        settingCardText: Color(0xff052a3a),
      ),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Cairo',
    extensions: [
      AppColors(
        scaffoldBackground: Color(0xff0c0f14),
        navigaionBar: Color(0xff25282d),
        wordCard: Color(0xff1d1e22),
        wordCardText: Color(0xffffffff),
        wordCardIcon: Color(0xff8B3DFF),
        cardShadow: Colors.transparent,
        settingCardIcon: Color(0xff8e8f91),
        settingCardText: Color(0xffffffff),
      ),
    ],
  );
}

// الألوان السابقة قبل تغييرها في اللايت مود

// scaffoldBackground: Color(0xffffffff),
//         navigaionBar: Color(0xffe2eafc),
//         wordCard: Color(0xfff4f5f7),

// الألوان السابقة قبل تغييرها في الدارك مود
// scaffoldBackground: Color(0xff161618),
//         navigaionBar: Color(0xff313236),
