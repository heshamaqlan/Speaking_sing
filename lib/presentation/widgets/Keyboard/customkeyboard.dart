import 'package:flutter/material.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';

class KeyboardButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onPressed;
  final bool isSpecial;

  const KeyboardButton({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.onPressed,
    this.isSpecial = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery للحصول على أبعاد الشاشة الكلية للمساعدة في الحسابات العامة
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          // تحديد حالة الشاشات الصغيرة جداً بناءً على المساحة المتاحة للزر نفسه
          final isSmall = h < 50 || w < 30;

          return Padding(
            // Padding مستجيب: يتغير حسب عرض المساحة المتاحة
            padding: EdgeInsets.all(
              w * 0.05,
            ).clamp(const EdgeInsets.all(2), const EdgeInsets.all(8)),
            child: InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: onPressed,
              child: Container(
                decoration: BoxDecoration(
                  color: isSpecial ? Colors.grey[300] : Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade300, width: 0.5),
                  boxShadow: [
                    if (!isSpecial)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imagePath.isNotEmpty)
                      Expanded(
                        flex:
                            isSmall
                                ? 6
                                : 7, // تقليل حجم الصورة في المساحات الضيقة
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                w * 0.1, // ترك مسافة جانبية للصورة لتظل متناسقة
                            vertical: h * 0.05,
                          ),
                          child: Image.asset(
                            imagePath,
                            fit:
                                BoxFit
                                    .contain, // يضمن عدم تمدد الصورة وحفاظها على أبعادها
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.image_not_supported,
                                size: (h * 0.3).clamp(15.0, 30.0),
                              );
                            },
                          ),
                        ),
                      ),

                    Expanded(
                      flex: isSmall ? 4 : 3,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // أهم سطر للاستجابة: الخط يتغير حسب الارتفاع مع حدود دنيا وقصوى
                            fontSize: (h * 0.22).clamp(
                              9.0,
                              isLandscape ? 14.0 : 18.0,
                            ),
                            fontWeight:
                                isSpecial ? FontWeight.bold : FontWeight.w600,
                            color: isSpecial ? Colors.black : Colors.grey[800],
                            fontFamily: "Cairo",
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
