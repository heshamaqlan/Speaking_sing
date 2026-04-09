import 'package:hive/hive.dart';

part 'animation_model.g.dart';

@HiveType(typeId: 0)
class AnimationModel extends HiveObject {
  @HiveField(0)
  final String nameAr; // اسم الحركة بالعربي

  @HiveField(1)
  final String animationCode; // الاسم في بلندر (المفتاح)

  @HiveField(2)
  final String category; // الفئة

  @HiveField(3)
  bool isFavorite; // قابلة للتغيير لاحقاً

  AnimationModel({
    required this.nameAr,
    required this.animationCode,
    required this.category,
    this.isFavorite = false,
  });
}
