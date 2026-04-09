import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';
import 'package:speaking_sign/controller/keyboard/keboard_controller.dart';
import 'package:speaking_sign/data/static/static.dart';
import 'package:speaking_sign/presentation/widgets/Keyboard/customkeyboard.dart';
import 'package:speaking_sign/presentation/widgets/public/custom_top_header2.dart';

class Keyboard extends StatelessWidget {
  Keyboard({Key? key}) : super(key: key);

  final KeyboardController controller = Get.find<KeyboardController>();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        top: false, // Let CustomTopHeader2 handle its top padding
        bottom: true,
        // LayoutBuilder يعطينا الارتفاع الفعلي المتاح بعد SafeArea
        child: LayoutBuilder(
          builder: (context, bodyConstraints) {
            // الثلثان العلويان من الارتفاع الفعلي المتاح
            final keyboardHeight = bodyConstraints.maxHeight * (2 / 2.2);

            return Column(
              children: [
                // ─── منطقة الكيبورد: الثلثان العلويان تماماً ───
                SizedBox(
                  height: keyboardHeight,
                  child: Column(
                    children: [
                      CustomTopHeader2(text: "لوحة المفاتيح الإشارية"),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 800),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final h = constraints.maxHeight;
                                final w = constraints.maxWidth;

                                return Column(
                                  children: [
                                    // 1. Text Display Area
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: (w * 0.04).clamp(
                                          16.0,
                                          24.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Obx(
                                              () => SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                reverse: true,
                                                child: Text(
                                                  controller.displayText.value,
                                                  style: TextStyle(
                                                    fontFamily: "Cairo",
                                                    color: colors.wordCard,
                                                    fontSize: (w * 0.045).clamp(
                                                      18.0,
                                                      28.0,
                                                    ),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            ": النــص",
                                            style: TextStyle(
                                              fontFamily: "Cairo",
                                              color: Colors.purple,
                                              fontSize: (w * 0.05).clamp(
                                                18.0,
                                                28.0,
                                              ),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Divider(
                                      color: Colors.black.withOpacity(0.15),
                                      thickness: 2,
                                      indent: 24,
                                      endIndent: 24,
                                    ),

                                    // 2. Selected Signs Preview
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: (w * 0.04).clamp(
                                          16.0,
                                          24.0,
                                        ),
                                        vertical: (h * 0.01).clamp(4.0, 8.0),
                                      ),
                                      padding: EdgeInsets.all(
                                        (h * 0.01).clamp(4.0, 10.0),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.purple.shade200,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                        color: Colors.purple.withOpacity(0.02),
                                      ),
                                      height: (h * 0.15).clamp(60.0, 120.0),
                                      child: LayoutBuilder(
                                        builder: (context, signConstraints) {
                                          return Obx(
                                            () => ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  controller.inputSigns.length,
                                              itemBuilder: (context, index) {
                                                final sign =
                                                    controller
                                                        .inputSigns[index];
                                                if (sign.char == " ") {
                                                  return SizedBox(
                                                    width:
                                                        signConstraints
                                                            .maxHeight *
                                                        0.5,
                                                  );
                                                }
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 4.0,
                                                      ),
                                                  child: Image.asset(
                                                    sign.assetpath!,
                                                    height:
                                                        signConstraints
                                                            .maxHeight *
                                                        0.9,
                                                    fit: BoxFit.contain,
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    // 3. The Keyboard Container
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: (w * 0.02).clamp(
                                            4.0,
                                            12.0,
                                          ),
                                          vertical: (h * 0.01).clamp(2.0, 8.0),
                                        ),
                                        child: Column(
                                          children: [
                                            // Keyboard Rows
                                            ...keboardlist.map((row) {
                                              return Expanded(
                                                flex: 4,
                                                child: Row(
                                                  children:
                                                      row.map((sign) {
                                                        return KeyboardButton(
                                                          label: sign.char!,
                                                          imagePath:
                                                              sign.assetpath!,
                                                          onPressed:
                                                              () => controller
                                                                  .addSign(
                                                                    sign,
                                                                  ),
                                                        );
                                                      }).toList(),
                                                ),
                                              );
                                            }).toList(),

                                            const SizedBox(height: 8),

                                            // Action Buttons
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 4.0,
                                                    ),
                                                child: Row(
                                                  children: [
                                                    _buildActionButton(
                                                      label: 'مســح',
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            235,
                                                            160,
                                                            160,
                                                          ),
                                                      onPressed:
                                                          controller.deleteLast,
                                                    ),
                                                    _buildActionButton(
                                                      label: 'مسافـــة',
                                                      color:
                                                          Colors.grey.shade200,
                                                      onPressed:
                                                          controller.addSpace,
                                                    ),
                                                    _buildActionButton(
                                                      label: 'اذهـــب',
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            215,
                                                            180,
                                                            255,
                                                          ),
                                                      onPressed:
                                                          controller.submitText,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: (h * 0.02).clamp(
                                                4.0,
                                                16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ─── الثلث السفلي: فارغ تماماً (لا يوجد أي widget) ───
                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.zero,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, c) {
              return Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: (c.maxHeight * 0.35).clamp(14.0, 22.0),
                    color: Colors.black87,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
