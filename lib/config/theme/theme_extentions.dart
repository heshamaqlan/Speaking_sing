import 'package:flutter/material.dart';

@immutable
class AppExtras extends ThemeExtension<AppExtras> {
  final Color scaffoldBackground;
  final Color navigaionBar;
  final Color wordCard;
  final Color wordCardText;
  final Color wordCardIcon;
  final Color cardShadow;

  const AppExtras({
    required this.scaffoldBackground,
    required this.navigaionBar,
    required this.wordCard,
    required this.wordCardText,
    required this.wordCardIcon,
    required this.cardShadow,
  });

  @override
  AppExtras copyWith({
    Color? scaffoldBackground,
    Color? navigaionBar,
    Color? wordCard,
    Color? wordCardText,
    Color? wordCardIcon,
    Color? cardShadow,
  }) {
    return AppExtras(
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      navigaionBar: navigaionBar ?? this.navigaionBar,
      wordCard: wordCard ?? this.wordCard,
      wordCardText: wordCardText ?? this.wordCardText,
      wordCardIcon: wordCardIcon ?? this.wordCardIcon,
      cardShadow: cardShadow ?? this.cardShadow,
    );
  }

  @override
  AppExtras lerp(AppExtras? other, double t) {
    if (other == null) return this;

    return AppExtras(
      scaffoldBackground:
          Color.lerp(scaffoldBackground, other.scaffoldBackground, t)!,
      navigaionBar: Color.lerp(navigaionBar, other.navigaionBar, t)!,
      wordCard: Color.lerp(wordCard, other.wordCard, t)!,
      wordCardText: Color.lerp(wordCardText, other.wordCardText, t)!,
      wordCardIcon: Color.lerp(wordCardIcon, other.wordCardIcon, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
    );
  }
}