import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/modules/shared/widgets/colors.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(AppTheme.lightTheme);

  void toggleTheme() {
    AppTheme.toggleTheme();
    state = AppTheme.currentTheme;
  }

  void setDarkTheme() {
    AppTheme.isDarkMode = true;
    state = AppTheme.darkTheme;
  }

  void setLightTheme() {
    AppTheme.isDarkMode = false;
    state = AppTheme.lightTheme;
  }
}
