import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:posix/core/configs/assets/app_images.dart';
import 'package:posix/core/configs/theme/app_color.dart';

class AuthCard extends StatelessWidget {
  final Function onTap;

  const AuthCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: AppColors.cardBackground.withValues(alpha: 0.5),
                blurRadius: 1,
                spreadRadius: 2,
                offset: const Offset(0, 4))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          Text(
            "Biometric Authentication",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.transparent)),
            onPressed: () => onTap(),
            child: SvgPicture.asset(
              AppImages.authBiometriSvg,
              width: 100,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          )
        ],
      ),
    );
  }
}
