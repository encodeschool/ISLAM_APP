import 'package:flutter/material.dart';
import '../core/storage/local_storage.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode =
  LocalStorage.isDark ? ThemeMode.dark : ThemeMode.light;

  bool get isDark => themeMode == ThemeMode.dark;

  void toggleTheme(bool value) {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    LocalStorage.isDark = value;
    notifyListeners();
  }
}
