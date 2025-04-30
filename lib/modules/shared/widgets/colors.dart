import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that holds all the theme-related constants and configurations for the app.
class AppTheme {
  static bool isDarkMode = false;

  static void toggleTheme() {
    isDarkMode = !isDarkMode;
  }

  static ThemeData get currentTheme {
    return isDarkMode ? darkTheme : lightTheme;
  }

  /// The dark theme configuration for the app.
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.white,
        onPrimary: AppColors.black,
        secondary: AppColors.black,
        onSecondary: AppColors.black,
        error: AppColors.danger,
        onError: AppColors.black,
        surface: AppColors.greyBg,
        onSurface: AppColors.white,
        tertiary: AppColors.grey,
        onTertiary: AppColors.black,
      ),
      scaffoldBackgroundColor: AppColors.blackbg,
      textTheme: GoogleFonts.instrumentSansTextTheme(Typography.blackCupertino),
      iconTheme: const IconThemeData(color: AppColors.white),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.blackbg,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.white,
        selectionColor: AppColors.grey,
        selectionHandleColor: AppColors.white,
      ),
    );
  }

  /// The light theme configuration for the app.
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.black,
        onPrimary: AppColors.white,
        secondary: AppColors.white,
        onSecondary: AppColors.black,
        error: AppColors.danger,
        onError: AppColors.white,
        surface: AppColors.white10,
        onSurface: AppColors.black,
        tertiary: AppColors.grey,
        onTertiary: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.white,
      textTheme: GoogleFonts.instrumentSansTextTheme(Typography.blackCupertino),
      iconTheme: const IconThemeData(color: AppColors.black),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.black,
        selectionColor: AppColors.grey,
        selectionHandleColor: AppColors.black,
      ),
    );
  }
}

/// A class that holds all the color constants used throughout the app.
class AppColors {
  // White shades
  static const Color white = Color(0XFFFFFFFF);
  static const Color whitebg = Color(0xFFF3F3F3);
  static const Color white10 = Color(0XFFF0F0F0);
  static const Color white20 = Color(0XFFE8E8E8);
  static const Color white30 = Color(0XFFE0E0E0);

  // Grey shades
  static const Color darkGrey = Color(0xFF888888);
  static const Color grey = Color(0xFF919191);
  static const Color greyBg = Color(0xFF313131);

  // Black shades
  static const Color black = Color(0xFF0F0F0F);
  static const Color blackbg = Color(0xFF1F1F1F);
  static const Color black25 = Color(0XFFBFBFBF);
  static const Color black50 = Color(0XFF808080);
  static const Color black75 = Color(0XFF404040);

  // Status colors
  static const Color danger = Color(0xFFFF1B2E);
  static const Color danger10 = Color(0XFFFFC5C5);
  static const Color danger20 = Color(0XFFFF7F7F);

  static const Color success = Color(0XFF00C48C);
  static const Color success10 = Color(0XFF00F5C0);
  static const Color success20 = Color(0XFF00D9A2);
}
