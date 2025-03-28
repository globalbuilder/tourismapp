import 'package:flutter/material.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class ThemeManager extends ChangeNotifier {
  bool _isDarkMode = false;
  ThemeData _currentTheme = lightTheme;

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _currentTheme = _isDarkMode ? darkTheme : lightTheme;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    _currentTheme = value ? darkTheme : lightTheme;
    notifyListeners();
  }
}
