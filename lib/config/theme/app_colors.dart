import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? scaffoldBackground;
  final Color navigaionBar;
  final Color? wordCard;
  final Color? wordCardText;
  final Color? wordCardIcon;
  final Color cardShadow;
  final Color settingCardIcon;
  final Color settingCardText;

  AppColors({
    this.scaffoldBackground,
    required this.navigaionBar,
    this.wordCard,
    this.wordCardText,
    this.wordCardIcon,
    required this.cardShadow,
    required this.settingCardIcon,
    required this.settingCardText,
  });

  @override
  AppColors copyWith({
    Color? scaffoldBackground,
    Color? navigaionBar,
    Color? wordCard,
    Color? wordCardText,
    Color? wordCardIcon,
    Color? cardShadow,
    Color? settingCardIcon,
    Color? settingCardText,
  }) {
    return AppColors(
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      navigaionBar: navigaionBar ?? this.navigaionBar,
      wordCard: wordCard ?? this.wordCard,
      wordCardText: wordCardText ?? this.wordCardText,
      wordCardIcon: wordCardIcon ?? this.wordCardIcon,
      cardShadow: cardShadow ?? this.cardShadow,
      settingCardIcon: settingCardIcon ?? this.settingCardIcon,
      settingCardText: settingCardText ?? this.settingCardText,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      scaffoldBackground: Color.lerp(
        scaffoldBackground,
        other.scaffoldBackground,
        t,
      ),
      navigaionBar: Color.lerp(navigaionBar, other.navigaionBar, t)!,
      wordCard: Color.lerp(wordCard, other.wordCard, t),
      wordCardText: Color.lerp(wordCardText, other.wordCardText, t),
      wordCardIcon: Color.lerp(wordCardIcon, other.wordCardIcon, t),
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
      settingCardIcon: Color.lerp(settingCardIcon, other.settingCardIcon, t)!,
      settingCardText: Color.lerp(settingCardText, other.settingCardText, t)!,
    );
  }
}
