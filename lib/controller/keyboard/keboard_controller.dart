import 'package:get/get.dart';
import 'package:speaking_sign/data/models/keyboard/keboard_model.dart';
import 'package:speaking_sign/routes/app_routes.dart';

class KeyboardController extends GetxController {
  final RxList<KeyboardModel> inputSigns = <KeyboardModel>[].obs;

  final RxString displayText = " ".obs;

  void addSign(KeyboardModel sign) {
    inputSigns.add(sign);
  }

  void addSpace() {
    inputSigns.add(KeyboardModel(char: " ", assetpath: ""));
  }

  void deleteLast() {
    if (inputSigns.isNotEmpty) {
      inputSigns.removeLast();
    }
  }

  void clearInput() {
    inputSigns.clear();
  }

  void submitText() {
    String result = inputSigns.map((e) => e.char).join();
    displayText.value = result.isEmpty ? " " : result;
    // inputSigns.clear();
  }
}
