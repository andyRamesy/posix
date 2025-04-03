import 'package:flutter/material.dart';
import 'package:posix/core/configs/theme/app_color.dart';

class AppTheme {
  static const TextStyle _baseTextStyle = TextStyle(
    fontFamily: "ProximaNova",
  );
  static final appTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      background: AppColors.background,
      surface: AppColors.cardBackground,
      onPrimary: Colors.black, // Ensures readability on primary buttons
      onBackground: AppColors.text,
      onSurface: AppColors.text,
    ),
    textTheme: TextTheme(
      headlineLarge: _baseTextStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: AppColors.text,
      ),
      bodyLarge: _baseTextStyle.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
        fontSize: 16,
        color: AppColors.text,
      ),
      labelLarge: _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ) 
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.text,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardBackground,
      hintStyle: const TextStyle(color: AppColors.secondaryText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    cardTheme: const CardTheme(
      color: AppColors.cardBackground,
      elevation: 4,
      margin: EdgeInsets.all(8),
    ),
  );
}
