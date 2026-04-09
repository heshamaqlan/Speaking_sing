import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onTap});

  final void Function()? onTap;

  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xff8B3DFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
