import 'package:flutter/material.dart';
import 'package:sonata/utility/app_theme.dart';

enum ThemeType { light, dark }

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  ThemeData loadTheme() {
    return _themeMode == ThemeMode.light ? AppTheme.lightTheme : AppTheme.darkTheme;
  }
}
