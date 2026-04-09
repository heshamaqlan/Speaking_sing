import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speaking_sign/controller/settings/conction_theglavs/conctionthglovs_controller.dart';
import 'package:speaking_sign/data/static/static.dart';
import 'package:speaking_sign/presentation/widgets/Keyboard/customkeyboard.dart';

class Conctiontheglavs extends StatelessWidget {
  const Conctiontheglavs({super.key});

  @override
  Widget build(BuildContext context) {
    final ConctionthglovsController controller = Get.put(ConctionthglovsController());
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final titleFontSize = (screenWidth * 0.05).clamp(16.0, 24.0);
    final bodyFontSize = (screenWidth * 0.035).clamp(12.0, 16.0);
    final predictionFontSize = (screenWidth * 0.09).clamp(28.0, 42.0);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        body: Column(
          children: [
            // الهيدر
            _buildHeader(context, controller, screenWidth, screenHeight, titleFontSize),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // حقل الاسم المخصص
                    _buildNameField(context, controller),
                    const SizedBox(height: 12),

                    // حالة الاتصال
                    _buildConnectionStatus(controller, screenWidth, bodyFontSize),
                    const SizedBox(height: 8),
                    
                    Obx(() => Column(
                      children: [
                        Text("الشبكة: منفذ ${ConctionthglovsController.udpPort} | حزم البيانات: ${controller.packetsReceived.value}", textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        Text(controller.modelStatus.value, textAlign: TextAlign.center, style: TextStyle(color: controller.modelLoaded.value ? Colors.green : Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    )),
                    const SizedBox(height: 12),

                    // إعدادات الترجمة والشعور
                    _buildSettingsCard(controller),
                    const SizedBox(height: 10),

                    // خيارات النطق ووضع الجملة
                    _buildOptionsRow(controller),
                    
                    // اختيار جنس صوت القارئ
                    _buildVoiceGenderSelector(controller),
                    const SizedBox(height: 15),

                    // أزرار التحكم
                    _buildControlButtons(controller),
                    const SizedBox(height: 8),
                    
                    Obx(() => Text(controller.statusText.value, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, color: Colors.blueGrey, fontFamily: 'Cairo'))),
                    const SizedBox(height: 10),

                    // نتيجة التنبؤ
                    _buildPredictionCard(controller, predictionFontSize, screenWidth),
                    const SizedBox(height: 15),

                    // قسم وضع الجملة
                    _buildSentenceSection(controller),

                    // سجل التنبؤات
                    _buildHistoryLog(controller, screenHeight),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ConctionthglovsController controller, double screenWidth, double screenHeight, double titleFontSize) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        right: screenWidth * 0.05,
        left: screenWidth * 0.025,
        bottom: screenHeight * 0.025,
        top: MediaQuery.paddingOf(context).top + 10,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff8B3DFF), Color.fromARGB(255, 174, 143, 220)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text("التعرف على لغة الإشارة", style: TextStyle(fontFamily: 'Cairo', fontSize: titleFontSize, fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.ellipsis)),
          IconButton(
            onPressed: () => controller.navigateToSetting(),
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField(BuildContext context, ConctionthglovsController controller) {
    return TextField(
      controller: controller.customNameController,
      readOnly: true,
      onTap: () => _showCustomKeyboard(context, controller),
      decoration: InputDecoration(
        labelText: "اسم ذو الهمة العالية",
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(fontFamily: 'Cairo', fontSize: 14),
    );
  }

  Widget _buildConnectionStatus(ConctionthglovsController controller, double screenWidth, double bodyFontSize) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text("IP الخاص بالجوال (ضعه في شريحة ESP):", style: TextStyle(color: Colors.blueGrey, fontSize: bodyFontSize, fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
          Obx(() => Text(controller.localIp.value, style: TextStyle(color: Colors.blue, fontSize: (screenWidth * 0.05).clamp(16.0, 22.0), fontWeight: FontWeight.bold, fontFamily: 'Cairo'))),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(ConctionthglovsController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("اللغة:", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                Expanded(
                  child: Obx(() => DropdownButton<String>(
                    isExpanded: true,
                    value: controller.selectedLanguage.value,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    items: controller.languages.keys.map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontSize: 14)));
                    }).toList(),
                    onChanged: (val) => controller.selectedLanguage.value = val!,
                  )),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("الشعور:", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                Expanded(
                  child: Obx(() => DropdownButton<String>(
                    isExpanded: true,
                    value: controller.selectedEmotion.value,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    items: controller.emotions.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Text(controller.emotions[value]!['icon'], style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 8),
                            Text(value.replaceAll(RegExp(r'[^\w\s]'), '').trim(), style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => controller.selectedEmotion.value = val!,
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsRow(ConctionthglovsController controller) {
    return Row(
      children: [
        Expanded(
          child: Obx(() => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("🔊 تفعيل النطق", style: TextStyle(fontSize: 13, fontFamily: 'Cairo')),
            value: controller.ttsEnabled.value,
            onChanged: (val) => controller.ttsEnabled.value = val!,
            controlAffinity: ListTileControlAffinity.leading,
          )),
        ),
        Expanded(
          child: Obx(() => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("وضع الجملة", style: TextStyle(fontSize: 13, fontFamily: 'Cairo')),
            value: controller.sentenceMode.value,
            onChanged: (val) => controller.sentenceMode.value = val!,
            controlAffinity: ListTileControlAffinity.leading,
          )),
        ),
      ],
    );
  }

  Widget _buildVoiceGenderSelector(ConctionthglovsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("صوت القارئ:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
        const SizedBox(width: 16),
        Obx(() => Row(
          children: [
            Radio<String>(
              value: "رجل",
              groupValue: controller.voiceGender.value,
              onChanged: (val) => controller.voiceGender.value = val!,
            ),
            const Text("رجل", style: TextStyle(fontSize: 14, fontFamily: 'Cairo')),
            const SizedBox(width: 16),
            Radio<String>(
              value: "امرأة",
              groupValue: controller.voiceGender.value,
              onChanged: (val) => controller.voiceGender.value = val!,
            ),
            const Text("امرأة", style: TextStyle(fontSize: 14, fontFamily: 'Cairo')),
          ],
        )),
      ],
    );
  }

  Widget _buildControlButtons(ConctionthglovsController controller) {
    return Obx(() => ElevatedButton(
      onPressed: controller.toggleListening,
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.isListening.value ? Colors.redAccent : const Color(0xff8B3DFF),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        controller.isListening.value ? "إيقاف التعرف" : "بدء التعرف على الإشارات",
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Cairo'),
      ),
    ));
  }

  Widget _buildPredictionCard(ConctionthglovsController controller, double predictionFontSize, double screenWidth) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Obx(() {
          Color confidenceColor = Colors.grey;
          if (controller.currentConfidence.value >= 0.8) confidenceColor = Colors.green;
          else if (controller.currentConfidence.value >= 0.5) confidenceColor = Colors.orange;
          else if (controller.currentConfidence.value > 0) confidenceColor = Colors.red;

          return Column(
            children: [
              const Text("نتيجة التنبؤ", style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Cairo')),
              const SizedBox(height: 8),
              Text(
                controller.currentPrediction.value,
                style: TextStyle(fontSize: predictionFontSize, fontWeight: FontWeight.bold, color: confidenceColor, fontFamily: 'Cairo'),
              ),
              if (controller.currentTranslation.value.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  "🌐 ${controller.currentTranslation.value}",
                  style: TextStyle(fontSize: (screenWidth * 0.055).clamp(16.0, 24.0), color: Colors.purple, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                "الثقة: ${(controller.currentConfidence.value * 100).toStringAsFixed(1)}%",
                style: TextStyle(fontSize: 14, color: confidenceColor, fontFamily: 'Cairo'),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSentenceSection(ConctionthglovsController controller) {
    return Obx(() => controller.sentenceMode.value ? Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("الجملة الحالية:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
        Card(
          elevation: 1,
          color: const Color(0xFFE3F2FD),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  controller.fullSentenceText.value.isEmpty ? "..." : controller.fullSentenceText.value,
                  style: const TextStyle(fontSize: 22, color: Color(0xFF1565C0), fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  controller.sentenceStatusText.value,
                  style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Cairo'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    ) : const SizedBox.shrink());
  }

  Widget _buildHistoryLog(ConctionthglovsController controller, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("السجل:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
        Container(
          height: (screenHeight * 0.15).clamp(100.0, 150.0),
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
          child: Obx(() => ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.historyLog.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(controller.historyLog[index], style: const TextStyle(fontSize: 12, fontFamily: 'Cairo')),
              );
            },
          )),
        ),
      ],
    );
  }

  void _showCustomKeyboard(BuildContext context, ConctionthglovsController controller) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final screenHeight = MediaQuery.sizeOf(context).height;
        return Container(
          height: (screenHeight * 0.5).clamp(300.0, 500.0),
          decoration: const BoxDecoration(
            color: Color(0xFFF7F9FC),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ),
              Expanded(
                child: Column(
                  children: [
                    ...keboardlist.map((row) {
                      return Expanded(
                        child: Row(
                          children: row.map((sign) {
                            return KeyboardButton(
                              label: sign.char!,
                              imagePath: sign.assetpath!,
                              onPressed: () {
                                controller.customNameController.text += sign.char!;
                              },
                            );
                          }).toList(),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: (screenHeight * 0.065).clamp(42.0, 60.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (controller.customNameController.text.isNotEmpty) {
                                    controller.customNameController.text = controller.customNameController.text.substring(0, controller.customNameController.text.length - 1);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 181, 115, 115),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                ),
                                child: const Text('مســح', style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: "Cairo", fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.customNameController.text += " ";
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                ),
                                child: const Text('مسافـــة', style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: "Cairo", fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 203, 168, 168),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                ),
                                child: const Text('تم', style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: "Cairo", fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
