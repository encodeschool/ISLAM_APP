// lib/providers/user_settings_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsProvider with ChangeNotifier {
  static const _genderKey = 'user_gender';
  static const _madhhabKey = 'user_madhhab';

  String _gender = 'male';
  String _madhhab = 'hanafi';

  String get gender => _gender;
  String get madhhab => _madhhab;

  /// Load settings on app start
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _gender = prefs.getString(_genderKey) ?? 'male';
    _madhhab = prefs.getString(_madhhabKey) ?? 'hanafi';
    notifyListeners();
  }

  void setGender(String value) async {
    _gender = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_genderKey, value);
  }

  void setMadhhab(String value) async {
    _madhhab = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_madhhabKey, value);
  }
}
