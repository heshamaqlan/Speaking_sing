import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speaking_sign/config/theme/app_theme.dart';

class ThemeController extends GetxController {
  static const _storageKey = 'theme';

  final themeMode = ThemeMode.system.obs;

  ThemeData get light => AppTheme.lightTheme;
  ThemeData get dark => AppTheme.darkTheme;
 
  @override
  void onInit() {
    super.onInit();
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_storageKey);
    themeMode.value = switch (saved) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  Future<void> changeTheme(ThemeMode mode) async {
    themeMode.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, mode.name);
  }
}   
