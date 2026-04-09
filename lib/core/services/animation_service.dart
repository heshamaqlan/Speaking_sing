// file: moves_service.dart

import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speaking_sign/config/constants/constants.dart';
import 'package:speaking_sign/data/models/animation/animation_model.dart';

class AnimationService {
  // 1. تعريف الصندوق المفتوح
  final Box<AnimationModel> _movesBox = Hive.box<AnimationModel>(kAnimationBox);

  // 2. دالة جلب مسار ملف GLB
  Future<String> get localGlbPath async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/avatar.glb'; 
  }

  // 3. دالة إضافة حركة جديدة (تستخدم في AddMoveCubit)
  Future<void> addMove(AnimationModel move) async {
    await _movesBox.add(move);
  }

  // 4. دالة جلب كل الحركات (تستخدم في LoadMovesCubit)
  List<AnimationModel> getAllMoves() {
    return _movesBox.values.toList();
  }
  
  // 5. دالة تبديل حالة المفضلة (تستخدم في LoadMovesCubit)
  Future<void> toggleFavorite(AnimationModel move) async {
    move.isFavorite = !move.isFavorite;
    await move.save(); 
  }

  // 6. دالة استبدال ملف GLB (تستخدم في AddMoveCubit)
  Future<bool> updateGlbFile(String sourcePath) async {
    try {
      final destinationPath = await localGlbPath;
      final sourceFile = File(sourcePath);
      // عملية النسخ والاستبدال
      await sourceFile.copy(destinationPath);
      return true;
    } catch (e) {
      print("خطأ في تحديث ملف GLB: $e");
      return false;
    }
  }
}