import 'package:speaking_sign/config/constants/app_image.dart';
import 'package:speaking_sign/data/models/keyboard/keboard_model.dart';
import 'package:speaking_sign/data/models/onboarding/onboarding_model.dart';

List<Onbordingmodel> onbordinglist = [
  Onbordingmodel(
    title: "SpeakingSing مرحبــاً بك في",
    body:
        "ترجمتك الفورية للغة الاشارة اجعل التواصل متاحاً وشاملاً واكسر حواجز الخجل حول أي نص تكتبة او تنطقة الى شخصية حركية",
    image: AppImage.onBordingimage,
  ),
  Onbordingmodel(
    title: "!تواصل بلا جهد وبسرعة",
    body:
        "لا حاجة لتعلم الإشارة المعقدة. فقط اكتب أو انطق جملتك، وسيقوم التطبيق بتحويلها فوراً إلى حركة مفهومة",
    image: AppImage.onBordingimageTow,
  ),
  Onbordingmodel(
    title: "قاموس الإشارة بين يديك",
    body: """استكشف مكتبة ضخمة من الكلمات والإشارات
 ابحث عن أي كلمة وشاهد كيف تُؤدّى بواسطة الشخصية الحركية""",
    image: AppImage.onBordingimageThree,
  ),
  Onbordingmodel(
    title: "شخصيتك.. بإشارتك",
    body: """احفظ العبارات المتكررة
     لتستخدمها بضغطة زر واحدة لاحقًا""",
    image: AppImage.onBordingimageFoure,
  ),
];

final List<List<KeyboardModel>> keboardlist = [
  [
    KeyboardModel(char: "0", assetpath: ""),
    KeyboardModel(char: "1", assetpath: ""),
    KeyboardModel(char: "2", assetpath: ""),
    KeyboardModel(char: "3", assetpath: ""),
    KeyboardModel(char: "4", assetpath: ""),
    KeyboardModel(char: "5", assetpath: ""),
    KeyboardModel(char: "6", assetpath: ""),
    KeyboardModel(char: "7", assetpath: ""),
    KeyboardModel(char: "8", assetpath: ""),
    KeyboardModel(char: "9", assetpath: ""),
  ],
  [
    KeyboardModel(char: "ض", assetpath: AppImage.charDT),
    KeyboardModel(char: "ص", assetpath: AppImage.charSS),
    KeyboardModel(char: "ث", assetpath: AppImage.charTH),
    KeyboardModel(char: "ق", assetpath: AppImage.charQ),
    KeyboardModel(char: "ف", assetpath: AppImage.charF),
    KeyboardModel(char: "غ", assetpath: AppImage.charGH),
    KeyboardModel(char: "ع", assetpath: AppImage.charAA),
    KeyboardModel(char: "هـ", assetpath: AppImage.charHE),
    KeyboardModel(char: "خ", assetpath: AppImage.charKH),
    KeyboardModel(char: "ج", assetpath: AppImage.charG),
    KeyboardModel(char: "ح", assetpath: AppImage.charH),
    KeyboardModel(char: "ة", assetpath: AppImage.charTTT),
  ],
  [
    KeyboardModel(char: "ش", assetpath: AppImage.charSH),
    KeyboardModel(char: "س", assetpath: AppImage.charS),
    KeyboardModel(char: "ي", assetpath: AppImage.charE),
    KeyboardModel(char: "ب", assetpath: AppImage.charB),
    KeyboardModel(char: "ل", assetpath: AppImage.charL),
    KeyboardModel(char: "ا", assetpath: AppImage.charA),
    KeyboardModel(char: "ت", assetpath: AppImage.charT),
    KeyboardModel(char: "ن", assetpath: AppImage.charN),
    KeyboardModel(char: "م", assetpath: AppImage.charM),
    KeyboardModel(char: "ك", assetpath: AppImage.charK),
    KeyboardModel(char: "ذ", assetpath: AppImage.charTh2),
    KeyboardModel(char: "د", assetpath: AppImage.charD),
  ],
  [
    KeyboardModel(char: "ظ", assetpath: AppImage.charTH3),
    KeyboardModel(char: "ط", assetpath: AppImage.charTA),
    KeyboardModel(char: "ر", assetpath: AppImage.charR),
    KeyboardModel(char: "ز", assetpath: AppImage.charZ),
    KeyboardModel(char: "و", assetpath: AppImage.charW),
    KeyboardModel(char: "ى", assetpath: AppImage.charA2),
    KeyboardModel(char: "أ", assetpath: AppImage.charAAAA),
    KeyboardModel(char: "إ", assetpath: AppImage.charAEE),
    KeyboardModel(char: "ؤ", assetpath: AppImage.charWA),
    KeyboardModel(char: "ئ", assetpath: AppImage.charAAA),
    KeyboardModel(char: "ء", assetpath: AppImage.charAE),
  ],
];
