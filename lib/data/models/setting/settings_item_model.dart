import 'package:flutter/material.dart';

class SettingsItemModel {
  final String title;
  final IconData icon;
  final bool isEnabled;
  final void Function()? onTap;

  const SettingsItemModel( {
    required this.title,
    required this.icon,
    this.isEnabled = false,
    this.onTap,
  });
}