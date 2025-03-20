import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:posix/core/configs/assets/app_images.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        AppImages.svgBasePath,
      ),
    );
  }
}
