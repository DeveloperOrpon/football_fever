import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_fever/appearance/themes/text_style.dart';
import 'colors.dart';

class AppThemes {
  static ThemeData main({bool isDark = false}) {
    return ThemeData(
      secondaryHeaderColor:
          isDark ? const Color(0xFF282837) : const Color(0xFFF6F8FE),
      primaryColor: AppColors.primary,
      primarySwatch: AppColors.primaryMaterialColor,
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: AppTextStyles.fontFamily,
      scaffoldBackgroundColor: isDark ? AppColors.dark : AppColors.white,
      appBarTheme: AppBarTheme(
        // iconTheme: IconThemeData(
        //   color: isDark ? AppColors.dark : AppColors.white,
        // ),
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: Colors.transparent,
        //   statusBarBrightness: Brightness.dark,
        //   statusBarIconBrightness: Brightness.light,
        // ),
        backgroundColor: isDark ? AppColors.dark : AppColors.white,
        elevation: 0,
      ),
      shadowColor: isDark ? const Color(0xFF1D1D2F) : Colors.grey.shade200,
      cardColor: isDark ? AppColors.blackLight : AppColors.white,
      iconTheme: IconThemeData(
        color: isDark ? Colors.white : Colors.black,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              textStyle: WidgetStatePropertyAll(TextStyle(
                color: isDark ? AppColors.white : AppColors.dark,
              )),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
              side: const WidgetStatePropertyAll(BorderSide(
                color: AppColors.primary,
                width: .5,
              )))),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFFF6F8FE),
        filled: true,
        hintStyle: const TextStyle(
          color: Colors.black54,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: .2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
        titleLarge: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 16.sp,
        ),
        titleMedium: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 15.sp,
        ),
        titleSmall: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 13.sp,
        ),
        labelLarge: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 14.sp,
        ),
        labelMedium: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 12.sp,
        ),
        labelSmall: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 10.sp,
        ),
        displayLarge: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 16.sp,
        ),
        bodyMedium: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 13.sp,
        ),
        bodySmall: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 11.sp,
        ),
        bodyLarge: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
