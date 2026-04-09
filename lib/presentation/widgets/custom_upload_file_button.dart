import 'package:flutter/material.dart';
import 'package:speaking_sign/config/theme/app_colors.dart';

class CustomUplodFileButton extends StatelessWidget {
  const CustomUplodFileButton({
    super.key,
    required this.colors,
  });

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'الملف الجديد',
            style: TextStyle(
              color: colors.wordCardText,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 24,
            ),
            decoration: BoxDecoration(
              color: colors.wordCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.wordCardText!)
            ),
            child: Column(
              children: [
                Icon(Icons.upload_file, size: 32),
                SizedBox(height: 12),
                Text(
                  'اختيار ملف الحركة الجديد',
                  style: TextStyle(
                    color: colors.wordCardText,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8,),
          Text(
            ' ملاحظة : سيتم استبدال الملف الحالي بالملف الجديد *',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
