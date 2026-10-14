import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

/// Type scale measured from the reference design (375pt wide frame).
/// Getters, because `.sp` needs ScreenUtil to be initialised first.
abstract final class AppTextStyles {
  /// Bundled in assets/fonts, registered in pubspec.yaml.
  static const fontFamily = 'Inter';
  static const accentFontFamily = 'PlusJakartaSans';

  static TextStyle get sectionTitle => TextStyle(
        fontFamily: fontFamily,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
      );

  static TextStyle get sectionTitleSmall => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
      );

  /// "Explore Places with Ride app" heading.
  static TextStyle get sectionTitleAccent => sectionTitleSmall.copyWith(fontFamily: accentFontFamily);

  static TextStyle get cardTitle => TextStyle(
        fontFamily: accentFontFamily,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get cardTitleLarge => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
      );

  static TextStyle get cardSubtitle => TextStyle(
        fontFamily: accentFontFamily,
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  /// "Book Auto Rides with Us" on the auto card.
  static TextStyle get autoCardSubtitle => TextStyle(
        fontFamily: accentFontFamily,
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get placeTitle => TextStyle(
        fontFamily: fontFamily,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get caption => TextStyle(
        fontFamily: fontFamily,
        fontSize: 10.sp,
        color: AppColors.textSecondary,
      );

  static TextStyle get hint => TextStyle(
        fontFamily: fontFamily,
        fontSize: 12.sp,
        color: AppColors.textHint,
      );

  static TextStyle get label => TextStyle(
        fontFamily: fontFamily,
        fontSize: 12.sp,
        color: AppColors.textPrimary,
      );

  static TextStyle get labelBold => TextStyle(
        fontFamily: fontFamily,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  /// Plus Jakarta Sans tops out at ExtraBold (800); the design asked for 900.
  static TextStyle get badge => TextStyle(
        fontFamily: accentFontFamily,
        fontSize: 10.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  static TextStyle get overlayTitle => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.25,
        shadows: const [Shadow(color: Color(0x66000000), blurRadius: 6)],
      );

  static TextStyle get navLabel => TextStyle(
        fontFamily: fontFamily,
        fontSize: 8.sp,
        color: AppColors.textSecondary,
      );

  static TextStyle get appBarTitle => TextStyle(
        fontFamily: fontFamily,
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );
}
