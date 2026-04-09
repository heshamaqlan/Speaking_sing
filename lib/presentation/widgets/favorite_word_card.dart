import 'package:flutter/material.dart';
import 'package:speaking_sign/config/constants/constants.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';
import 'package:speaking_sign/presentation/widgets/animated_border_painter.dart';

class FavoriteWordCard extends StatefulWidget {
  const FavoriteWordCard({
    super.key,
    required this.text,
    this.enableFlowAnimation = true,
    this.animationSpeed = 2.0,
    required this.gradientColors,
    required this.glowIntensity,
    required this.isSelected,
  });

  final String text;
  final bool enableFlowAnimation;


  final double animationSpeed;


  final List<Color> gradientColors;


  final double glowIntensity;

  final bool isSelected;

  @override
  State<FavoriteWordCard> createState() => _FavoriteWordCardState();
}

class _FavoriteWordCardState extends State<FavoriteWordCard>
    with TickerProviderStateMixin {
  late AnimationController flowController;
  late AnimationController focusController;
  late AnimationController typingController;

  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;
  bool isTyping = false;

  @override
  void initState() {
    super.initState();

    flowController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (2000 / widget.animationSpeed).round()),
    )..repeat();

  
    focusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Typing animation controller
    typingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });

    if (isFocused) {
      focusController.forward();
    } else {
      focusController.reverse();
    }
  }

  void handleTextChange(String text) {
    if (widget.enableFlowAnimation) {
      isTyping = true;
      typingController.forward().then((_) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              isTyping = false;
            });
            typingController.reverse();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    flowController.dispose();
    focusController.dispose();
    typingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return AnimatedBuilder(
      animation: Listenable.merge([
        flowController,
        focusController,
        typingController,
      ]),
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow:
                widget.isSelected
                    ? [
                      BoxShadow(
                        color: widget.gradientColors[0].withOpacity(
                          widget.glowIntensity,
                        ),
                        blurRadius: 15,
                        spreadRadius: -2,
                      ),
                      BoxShadow(
                        color: widget.gradientColors[1].withOpacity(
                          widget.glowIntensity,
                        ),
                        blurRadius: 5,
                        spreadRadius: -40,
                      ),
                    ]
                    : [],
          ),
          child: CustomPaint(
            painter: AnimatedBorderPainter(
              flowProgress: flowController.value,
              focusProgress: focusController.value,
              typingProgress: typingController.value,
              borderRadius: 50,
              borderWidth: 3,
              gradientColors: const [
                Color(0xFFDA22FF),
                Color(0xFF9733EE),
                Color(0xFF667EEA),
              ],
              isFocused: isFocused,
              isTyping: isTyping,
            ),
            child: Container(
              height: 65,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.wordCard,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(4, 6),
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(
                  Icons.keyboard_double_arrow_left_rounded,
                  size: widget.isSelected ? 34 : 32,
                  color:
                      widget.isSelected
                          ? colors.wordCardIcon
                          : colors.wordCardText,
                ),
                title: Text(
                  widget.text,
                  style: TextStyle(color: colors.wordCardText),
                  textAlign: TextAlign.center,
                ),
                trailing: Image.asset(kBaseImage, fit: BoxFit.contain),
              ),
            ),
          ),
        );
      },
    );
  }
}
