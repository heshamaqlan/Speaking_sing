import 'package:flutter/material.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';
import 'package:speaking_sign/presentation/widgets/animated_border_painter.dart';

/// ð¨ AnimatedBorderTextField - A stunning text field with animated gradient border
/// that flows based on typing activity and cursor position.
///
/// Features:
/// - Animated gradient border that flows when typing
/// - Smooth focus animations
/// - Customizable colors, speed, and appearance
/// - Production-ready and reusable
/// - Supports all standard TextField properties
class AnimatedBorderTextField extends StatefulWidget {
  /// Hint text displayed when the field is empty
  final String hintText;

  /// Icon displayed at the start of the text field
  final Widget? prefixIcon;

  /// Icon displayed at the end of the text field
  final IconData? suffixIcon;

  /// Callback when suffix icon is tapped
  final VoidCallback? onSuffixIconTap;

  /// Whether to obscure text (for passwords)
  final bool obscureText;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Controller for the text field
  final TextEditingController? controller;

  /// Callback when text changes
  final ValueChanged<String>? onChanged;

  /// Callback when editing is complete
  final VoidCallback? onEditingComplete;

  /// Callback when form is submitted
  final ValueChanged<String>? onSubmitted;

  /// Maximum number of lines
  final int maxLines;

  /// Minimum number of lines
  final int? minLines;

  /// Maximum length of input
  final int? maxLength;

  /// Border radius
  final double borderRadius;

  /// Border width
  final double borderWidth;

  /// Gradient colors for the animated border
  final List<Color> gradientColors;

  /// Animation speed (higher = faster)
  final double animationSpeed;

  /// Glow intensity when focused
  final double glowIntensity;

  /// Enable/disable the flow animation
  final bool enableFlowAnimation;

  final AppColors colors;

  const AnimatedBorderTextField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.borderRadius = 16.0,
    this.borderWidth = 4.0,
    this.gradientColors = const [
      Color(0xFF667EEA),
      Color(0xFF764BA2),
      Color(0xFFF093FB),
      Color(0xFF667EEA),
    ],
    this.animationSpeed = 2.0,
    this.glowIntensity = 0.3,
    this.enableFlowAnimation = true, required this.colors,
  }) : super(key: key);

  @override
  State<AnimatedBorderTextField> createState() =>
      _AnimatedBorderTextFieldState();
}

class _AnimatedBorderTextFieldState extends State<AnimatedBorderTextField>
    with TickerProviderStateMixin {
  late AnimationController _flowController;
  late AnimationController _focusController;
  late AnimationController _typingController;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();

    // Flow animation controller - continuous rotation
    _flowController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (2000 / widget.animationSpeed).round()),
    )..repeat();

    // Focus animation controller
    _focusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Typing animation controller
    _typingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    if (_isFocused) {
      _focusController.forward();
    } else {
      _focusController.reverse();
    }
  }

  void _handleTextChange(String text) {
    if (widget.enableFlowAnimation) {
      _isTyping = true;
      _typingController.forward().then((_) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              _isTyping = false;
            });
            _typingController.reverse();
          }
        });
      });
    }

    widget.onChanged?.call(text);
  }

  @override
  void dispose() {
    _flowController.dispose();
    _focusController.dispose();
    _typingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _flowController,
        _focusController,
        _typingController,
      ]),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: widget.gradientColors[0].withOpacity(
                        widget.glowIntensity,
                      ),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: widget.gradientColors[1].withOpacity(
                        widget.glowIntensity,
                      ),
                      blurRadius: 30,
                      spreadRadius: -5,
                    ),
                  ]
                : [],
          ),
          child: CustomPaint(
            painter: AnimatedBorderPainter(
              flowProgress: _flowController.value,
              focusProgress: _focusController.value,
              typingProgress: _typingController.value,
              borderRadius: widget.borderRadius,
              borderWidth: widget.borderWidth,
              gradientColors: widget.gradientColors,
              isFocused: _isFocused,
              isTyping: _isTyping,
            ),
            child: Container(
              decoration: BoxDecoration(
                color:  widget.colors.wordCard,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: TextField(
                textDirection: TextDirection.rtl,
                controller: widget.controller,
                focusNode: _focusNode,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                maxLength: widget.maxLength,
                onChanged: _handleTextChange,
                onEditingComplete: widget.onEditingComplete,
                onSubmitted: widget.onSubmitted,
                style:  TextStyle(
                  color: widget.colors.wordCardText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  prefixIcon: widget.prefixIcon ,
                  suffixIcon: widget.suffixIcon != null
                      ? IconButton(
                          icon: Icon(
                            widget.suffixIcon,
                            color: _isFocused
                                ? widget.gradientColors[0]
                                : Colors.white.withOpacity(0.5),
                          ),
                          onPressed: widget.onSuffixIconTap,
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: widget.prefixIcon != null ? 8 : 20,
                    vertical: widget.maxLines > 1 ? 16 : 18,
                  ),
                  counterText: '',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}