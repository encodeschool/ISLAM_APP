import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDark => _prefs?.getBool('isDark') ?? false;
  static set isDark(bool value) =>
      _prefs?.setBool('isDark', value);

  static String get language =>
      _prefs?.getString('language') ?? 'en';
  static set language(String value) =>
      _prefs?.setString('language', value);

  static int get zikrCount =>
      _prefs?.getInt('zikrCount') ?? 0;
  static set zikrCount(int value) =>
      _prefs?.setInt('zikrCount', value);

  static int get zikrLimit =>
      _prefs?.getInt('zikrLimit') ?? 33;
  static set zikrLimit(int value) =>
      _prefs?.setInt('zikrLimit', value);

  static int getOffset(String prayer) =>
      _prefs?.getInt('offset_$prayer') ?? 0;

  static void setOffset(String prayer, int value) =>
      _prefs?.setInt('offset_$prayer', value);
}
