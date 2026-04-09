import 'package:flutter/material.dart';
import 'dart:math' as math;

/// ð¨ Custom painter for the animated gradient border
class AnimatedBorderPainter extends CustomPainter {
  final double flowProgress;
  final double focusProgress;
  final double typingProgress;
  final double borderRadius;
  final double borderWidth;
  final List<Color> gradientColors;
  final bool isFocused;
  final bool isTyping;

  AnimatedBorderPainter({
    required this.flowProgress,
    required this.focusProgress,
    required this.typingProgress,
    required this.borderRadius,
    required this.borderWidth,
    required this.gradientColors,
    required this.isFocused,
    required this.isTyping,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // Calculate animated rotation angle
    final rotation = flowProgress * 2 * math.pi;

    // Add typing boost to rotation
    final typingBoost = isTyping ? typingProgress * 0.5 : 0.0;
    final totalRotation = rotation + typingBoost;

    // Create sweeping gradient that rotates
    final gradient = SweepGradient(
      colors: gradientColors,
      stops: _generateStops(gradientColors.length),
      transform: GradientRotation(totalRotation),
      center: Alignment.center,
    );

    // Calculate border width with focus animation
    final animatedBorderWidth = borderWidth * (1 + focusProgress * 0.3);

    // Create paint for border
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = animatedBorderWidth;

    // Draw the animated border
    canvas.drawRRect(rrect, paint);

    // Add extra glow effect when typing
    if (isTyping) {
      final glowPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = animatedBorderWidth * 2
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          10 * typingProgress,
        );
      canvas.drawRRect(rrect, glowPaint);
    }
  }

  List<double> _generateStops(int colorCount) {
    return List.generate(colorCount, (index) => index / (colorCount - 1));
  }

  @override
  bool shouldRepaint(covariant AnimatedBorderPainter oldDelegate) {
    return oldDelegate.flowProgress != flowProgress ||
        oldDelegate.focusProgress != focusProgress ||
        oldDelegate.typingProgress != typingProgress ||
        oldDelegate.isFocused != isFocused ||
        oldDelegate.isTyping != isTyping;
  }
}
