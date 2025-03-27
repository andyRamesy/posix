import 'package:flutter/material.dart';
import 'package:posix/core/configs/theme/app_color.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function onPressedBtn;
  final Widget child;

  const CustomOutlinedButton(
      {super.key, required this.onPressedBtn, required this.child});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.transparent)),
      onPressed: () => onPressedBtn(),
      child: child,
    );
  }
}
