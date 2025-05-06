import 'package:flutter/material.dart';
import 'package:posix/core/configs/theme/app_color.dart';

class Custombutton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final TextStyle textStyle;
  final bool disabledButton;

  const Custombutton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    required this.textStyle,
    this.disabledButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: disabledButton
                ? AppColors.disabledButton
                : isPrimary
                    ? AppColors.primary
                    : AppColors.background,
            foregroundColor: isPrimary ? AppColors.customBlack : AppColors.text,
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 3),
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle,
        ));
  }
}
