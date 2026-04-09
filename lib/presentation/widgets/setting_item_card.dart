import 'package:flutter/material.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';
import 'package:speaking_sign/data/models/setting/settings_item_model.dart';

class SettingItemCard extends StatelessWidget {
  const SettingItemCard({super.key, required this.settingsItemModel});

  final SettingsItemModel settingsItemModel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: colors.wordCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: colors.cardShadow, blurRadius: 7, spreadRadius: 2),
        ],
      ),
      child: ListTile(
        leading: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 32,
          color: Color(0xff8B3DFF),
        ),
        title: Text(
          settingsItemModel.title,
          textAlign: TextAlign.right,
          style: TextStyle(color: colors.settingCardText, fontSize: 14),
        ),
        trailing: Icon(
          settingsItemModel.icon,
          size: 24,
          color: colors.settingCardIcon,
        ),
        onTap:  settingsItemModel.onTap,
      ),
    );
  }
}
