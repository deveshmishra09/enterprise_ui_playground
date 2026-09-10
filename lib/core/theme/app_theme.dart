import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Builds the light and dark [ThemeData] from [AppColors.primary] (`#af3a4a`).
/// `main.dart` passes these to `MaterialApp.router`.
abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;

    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: brightness,
        ).copyWith(
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          surface: isLight ? AppColors.lightSurface : AppColors.darkSurface,
          outline: isLight ? AppColors.lightOutline : AppColors.darkOutline,
        );

    final textColor = isLight
        ? AppColors.lightTextPrimary
        : AppColors.darkTextPrimary;

    final base = ThemeData(brightness: brightness);

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: isLight
          ? AppColors.lightBackground
          : AppColors.darkBackground,
      textTheme: GoogleFonts.interTextTheme(
        base.textTheme,
      ).apply(bodyColor: textColor, displayColor: textColor),
      dividerTheme: DividerThemeData(
        color: isLight ? AppColors.lightOutline : AppColors.darkOutline,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
