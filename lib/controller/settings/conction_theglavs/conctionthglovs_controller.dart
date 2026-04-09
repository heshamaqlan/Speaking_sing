import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../../../../config/gemini_config.dart';
import 'package:speaking_sign/data/static/static.dart';

class ConctionthglovsController extends GetxController {
  // إعدادات UDP
  static const int udpPort = 4444;
  RawDatagramSocket? _udpSocket;
  var packetsReceived = 0.obs;
  var localIp = "جاري جلب الـ IP...".obs;

  // إدارة الحركة والتنبؤ
  var isListening = false.obs;
  Map<String, List<double>> _latestData = {
    'L': List.filled(14, 0.0),
    'R': List.filled(14, 0.0),
  };
  List<List<double>> _currentSequence = [];
  int _sampleCount = 0;
  Timer? _monitorTimer;

  // إعدادات النموذج (TFLite)
  Interpreter? _interpreter;
  var modelLoaded = false.obs;
  var modelStatus = "جاري تحميل النموذج...".obs;
  List<double> _scalerMean = [];
  List<double> _scalerScale = [];
  int _maxLen = 177;
  int _numFeatures = 28;
  List<String> _classNames = [];

  // إعدادات الواجهة
  var selectedLanguage = "العربية (بدون ترجمة)".obs;
  var selectedEmotion = "عادي 😐".obs;
  var voiceGender = "امرأة".obs;
  var ttsEnabled = true.obs;
  var sentenceMode = false.obs;
  final TextEditingController customNameController = TextEditingController();

  int _lastEmotionIndex = -1;
  int _lastLangIndex = -1;

  // عرض النتائج
  var statusText = "الحالة: في انتظار البدء".obs;
  var currentPrediction = "---".obs;
  var currentConfidence = 0.0.obs;
  var currentTranslation = "".obs;

  // وضع الجملة
  List<String> _sentenceWords = [];
  String? _pendingWord;
  Timer? _wordTimer;
  Timer? _sentenceTimer;
  var fullSentenceText = "".obs;
  var sentenceStatusText = "".obs;

  // سجل التنبؤات
  var historyLog = <String>[].obs;
  final ScrollController scrollController = ScrollController();

  // أدوات النطق والذكاء الاصطناعي
  final FlutterTts _flutterTts = FlutterTts();
  GenerativeModel? get _geminiModel {
    if (GeminiConfig.apiKey.isNotEmpty &&
        GeminiConfig.apiKey != 'YOUR_API_KEY_HERE') {
      return GenerativeModel(
        model: GeminiConfig.modelName,
        apiKey: GeminiConfig.apiKey,
      );
    }
    return null;
  }

  final Map<String, String> languages = {
    "العربية (بدون ترجمة)": "ar",
    "English": "en",
    "Français": "fr",
    "Español": "es",
    "Türkçe": "tr",
    "اردو": "ur",
    "Deutsch": "de",
    "Italiano": "it",
    "Português": "pt",
    "中文": "zh",
    "日本語": "ja",
    "한국어": "ko",
    "हिन्दी": "hi",
    "Русский": "ru",
  };

  final Map<String, Map<String, dynamic>> emotions = {
    "عادي 😐": {
      "pitch": 1.0,
      "rate": 0.5,
      "volume": 1.0,
      "icon": "😐",
      "color": Colors.blueGrey,
    },
    "خائف 😨": {
      "pitch": 1.5,
      "rate": 0.8,
      "volume": 0.7,
      "icon": "😨",
      "color": Colors.purple,
    },
    "حزين 😢": {
      "pitch": 0.8,
      "rate": 0.3,
      "volume": 0.8,
      "icon": "😢",
      "color": Colors.blue,
    },
    "مستعجل 🏃": {
      "pitch": 1.1,
      "rate": 0.8,
      "volume": 1.0,
      "icon": "🏃",
      "color": Colors.deepOrange,
    },
    "غاضب 😠": {
      "pitch": 0.6,
      "rate": 0.7,
      "volume": 1.0,
      "icon": "😠",
      "color": Colors.red,
    },
    "سعيد 😄": {
      "pitch": 1.2,
      "rate": 0.6,
      "volume": 1.0,
      "icon": "😄",
      "color": Colors.green,
    },
    "هامس 🤫": {
      "pitch": 0.8,
      "rate": 0.3,
      "volume": 0.3,
      "icon": "🤫",
      "color": Colors.brown,
    },
  };

  @override
  void onInit() {
    super.onInit();
    fetchLocalIp();
    loadModels();
    startUdpListener();
    initTts();
  }

  @override
  void onClose() {
    _udpSocket?.close();
    _monitorTimer?.cancel();
    _wordTimer?.cancel();
    _sentenceTimer?.cancel();
    _interpreter?.close();
    _flutterTts.stop();
    scrollController.dispose();
    customNameController.dispose();
    super.onClose();
  }

  void navigateToSetting() {
    Get.back();
  }

  Future<void> fetchLocalIp() async {
    try {
      List<NetworkInterface> interfaces = await NetworkInterface.list();
      String? foundIp;
      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            foundIp = addr.address;
            if (interface.name.toLowerCase().contains('ap') ||
                interface.name.toLowerCase().contains('wlan')) {
              localIp.value = foundIp!;
              return;
            }
          }
        }
      }
      if (foundIp != null) {
        localIp.value = foundIp!;
      } else {
        localIp.value = "غير متصل بالشبكة";
      }
    } catch (_) {
      localIp.value = "خطأ في جلب الـ IP";
    }
  }

  Future<void> initTts() async {
    await _flutterTts.setSharedInstance(true);
    await _flutterTts
        .setIosAudioCategory(IosTextToSpeechAudioCategory.ambient, [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        ]);
  }

  Future<void> loadModels() async {
    try {
      _interpreter = await Interpreter.fromAsset(
        'assets/models/model_cnn1d.tflite',
      );
      String configStr = await rootBundle.loadString(
        'assets/models/flutter_config.json',
      );
      var configJs = json.decode(configStr);
      _maxLen = configJs['max_len'] ?? 177;
      _numFeatures = configJs['num_features'] ?? 28;
      List<dynamic> classes = configJs['class_names'];
      _classNames = classes.map((e) => e.toString()).toList();

      String scalerStr = await rootBundle.loadString(
        'assets/models/scaler_params.json',
      );
      var scalerJs = json.decode(scalerStr);
      _scalerMean = List<double>.from(
        scalerJs['mean'].map((x) => x.toDouble()),
      );
      _scalerScale = List<double>.from(
        scalerJs['scale'].map((x) => x.toDouble()),
      );

      modelLoaded.value = true;
      modelStatus.value = "النموذج جاهز (CNN1D)";
    } catch (e) {
      modelStatus.value = "خطأ في تحميل النموذج: $e";
    }
  }

  void startUdpListener() async {
    try {
      _udpSocket = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        udpPort,
      );
      _udpSocket?.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram? dg = _udpSocket?.receive();
          if (dg != null) {
            String line = utf8.decode(dg.data).trim();
            List<String> parts = line.split(',');
            if (parts.length >= 15) {
              String gloveId = parts[0];
              if (gloveId == 'L' || gloveId == 'R') {
                try {
                  List<double> vals =
                      parts.sublist(1, 15).map((e) => double.parse(e)).toList();
                  _latestData[gloveId] = vals;
                  packetsReceived.value++;

                  if (gloveId == 'R' && parts.length >= 17) {
                    int emotionIndex =
                        double.parse(parts[parts.length - 2]).toInt();
                    int langIndex =
                        double.parse(parts[parts.length - 1]).toInt();

                    if (emotionIndex >= 0 &&
                        emotionIndex < emotions.length &&
                        emotionIndex != _lastEmotionIndex) {
                      selectedEmotion.value = emotions.keys.elementAt(
                        emotionIndex,
                      );
                      _lastEmotionIndex = emotionIndex;
                    }

                    if (langIndex >= 0 &&
                        langIndex < languages.length &&
                        langIndex != _lastLangIndex) {
                      selectedLanguage.value = languages.keys.elementAt(
                        langIndex,
                      );
                      _lastLangIndex = langIndex;
                    }
                  }
                } catch (_) {}
              }
            }
          }
        }
      });
    } catch (e) {
      print("UDP setup error: $e");
    }
  }

  void toggleListening() {
    if (isListening.value) {
      stopListening();
    } else {
      startListening();
    }
  }

  void startListening() {
    if (!modelLoaded.value) {
      Get.snackbar(
        "تنبيه",
        "النموذج لم يتم تحميله بعد!",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    isListening.value = true;
    _currentSequence.clear();
    _sampleCount = 0;
    statusText.value = "الحالة: في انتظار الحركة...";

    _monitorTimer?.cancel();
    _monitorTimer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (!isListening.value) {
        timer.cancel();
        return;
      }
      _monitorLoop();
    });
  }

  void stopListening() {
    isListening.value = false;
    statusText.value = "الحالة: متوقف";
    _monitorTimer?.cancel();
    _cancelSentenceTimers();

    if (sentenceMode.value && _pendingWord != null) {
      _sentenceWords.add(_pendingWord!);
      _pendingWord = null;
    }

    if (sentenceMode.value && _sentenceWords.isNotEmpty) {
      String finalSentence = _sentenceWords.join(" ");
      fullSentenceText.value = finalSentence;
      sentenceStatusText.value = "جاري تصحيح الجملة بالذكاء الاصطناعي...";
      _sentenceWords.clear();
      _correctAndDisplaySentence(finalSentence, manualStop: true);
    }
  }

  void _monitorLoop() {
    List<double> combined = [..._latestData['L']!, ..._latestData['R']!];
    _currentSequence.add(combined);
    if (_currentSequence.length > _maxLen) {
      _currentSequence.removeAt(0);
    }
    _sampleCount++;

    if (_sampleCount >= 25) {
      _sampleCount = 0;
      _runInference();
    }
  }

  Future<void> _runInference() async {
    if (_currentSequence.isEmpty || _interpreter == null) return;
    try {
      List<List<double>> inputData = List.generate(_maxLen, (i) {
        if (i < _currentSequence.length) {
          return _currentSequence[i];
        } else {
          return List.filled(_numFeatures, 0.0);
        }
      });

      for (int i = 0; i < inputData.length; i++) {
        for (int j = 0; j < _numFeatures; j++) {
          inputData[i][j] =
              (inputData[i][j] - _scalerMean[j]) / _scalerScale[j];
        }
      }

      var input = [inputData];
      var output = List.filled(
        1 * _classNames.length,
        0.0,
      ).reshape([1, _classNames.length]);
      _interpreter!.run(input, output);

      List<double> probs = List<double>.from(output[0]);
      double maxProb = 0.0;
      int maxIdx = 0;
      for (int i = 0; i < probs.length; i++) {
        if (probs[i] > maxProb) {
          maxProb = probs[i];
          maxIdx = i;
        }
      }

      if (maxProb > 0.75) {
        String pred = _classNames[maxIdx];
        if (pred != "Background" && pred != currentPrediction.value) {
          _processPrediction(pred, maxProb);
        }
      }
    } catch (e) {
      print("Inference error: $e");
    }
  }

  void _processPrediction(String pred, double confidence) async {
    currentPrediction.value = pred;
    currentConfidence.value = confidence;
    statusText.value = "تم رصد: $pred";

    String textToOutput = pred;
    String? translation;
    if (selectedLanguage.value != "العربية (بدون ترجمة)") {
      translation = await _translateTextWithGemini(
        pred,
        selectedLanguage.value,
      );
      if (translation != null) {
        currentTranslation.value = translation;
        textToOutput = translation;
      }
    } else {
      currentTranslation.value = "";
    }

    if (!sentenceMode.value) {
      _addToHistory(
        "[${_timeNow()}] $pred ${translation != null ? '($translation)' : ''}",
      );
      _speakText(textToOutput, languages[selectedLanguage.value]!);
    } else {
      _handleSentenceMode(pred, textToOutput);
    }
  }

  void _handleSentenceMode(String pred, String translated) {
    _pendingWord = translated;
    sentenceStatusText.value =
        "تم رصد كلمة: $translated... في انتظار الكلمة التالية";

    _wordTimer?.cancel();
    _wordTimer = Timer(const Duration(seconds: 3), () {
      if (_pendingWord != null) {
        _sentenceWords.add(_pendingWord!);
        fullSentenceText.value = _sentenceWords.join(" ");
        _pendingWord = null;
        sentenceStatusText.value = "تمت إضافة الكلمة. واصل الحركة...";
      }
    });

    _sentenceTimer?.cancel();
    _sentenceTimer = Timer(const Duration(seconds: 7), () {
      if (_sentenceWords.isNotEmpty) {
        String sentence = _sentenceWords.join(" ");
        _sentenceWords.clear();
        _correctAndDisplaySentence(sentence);
      }
    });
  }

  Future<void> _correctAndDisplaySentence(
    String sentence, {
    bool manualStop = false,
  }) async {
    sentenceStatusText.value = "جاري تحسين الجملة...";
    String? corrected = await _correctSentenceWithGemini(sentence);
    String finalShow = corrected ?? sentence;

    fullSentenceText.value = finalShow;
    _addToHistory("[${_timeNow()}] جملة: $finalShow");
    _speakText(finalShow, languages[selectedLanguage.value]!);
    sentenceStatusText.value =
        manualStop ? "انتهى التسجيل" : "تم نطق الجملة. ابدأ جملة جديدة...";
  }

  void _cancelSentenceTimers() {
    _wordTimer?.cancel();
    _sentenceTimer?.cancel();
  }

  Future<String?> _correctSentenceWithGemini(String sentence) async {
    if (_geminiModel == null) return null;
    try {
      final prompt =
          "أنت مصحح لغوي عربي متخصص تعمل داخل قفاز يقوم بترجمة وتحويل لغة الاشارة الى لغة منطوقة ومقرءة. مهمتك الوحيدة هي تصحيح الأخطاء النحوية والصرفية والإملائية في الجملة المُعطاة...\nصحح هذه الجملة: $sentence";
      final content = [Content.text(prompt)];
      final response = await _geminiModel!.generateContent(content);
      return response.text?.trim();
    } catch (e) {
      return null;
    }
  }

  Future<String?> _translateTextWithGemini(String text, String langName) async {
    if (_geminiModel == null) return null;
    try {
      final prompt =
          "أنت مترجم محترف. ترجم النص العربي التالي إلى $langName.\nأعد الترجمة فقط بدون أي شرح وحافظ على المعنى.\n\nترجم: $text";
      final content = [Content.text(prompt)];
      final response = await _geminiModel!.generateContent(content);
      return response.text?.trim();
    } catch (e) {
      return null;
    }
  }

  Future<void> _speakText(String text, String langCode) async {
    if (!ttsEnabled.value) return;
    try {
      await _flutterTts.setLanguage(langCode);
      var emotion = emotions[selectedEmotion.value]!;
      double basePitch = voiceGender.value == "رجل" ? 0.85 : 1.15;
      double emotionPitch = emotion['pitch'] as double;
      await _flutterTts.setPitch((basePitch * emotionPitch).clamp(0.1, 2.0));
      await _flutterTts.setSpeechRate(emotion['rate'] as double);
      await _flutterTts.setVolume(emotion['volume'] as double);
      await _flutterTts.speak(text);
    } catch (e) {}
  }

  void _addToHistory(String log) {
    historyLog.insert(0, log);
  }

  String _timeNow() {
    return "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}";
  }
}
