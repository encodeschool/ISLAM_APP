import 'package:shared_preferences/shared_preferences.dart';

import '../../models/prayer_notification_settings.dart';

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

  static Future<void> setPrayerNotification(
      String prayer,
      bool enabled,
      int minutesBefore,
      String sound,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_$prayer', enabled);
    await prefs.setInt('notif_${prayer}_before', minutesBefore);
    await prefs.setString('notif_${prayer}_sound', sound);
  }

  static PrayerNotificationSettings getPrayerNotification(String prayer) {
    return PrayerNotificationSettings(
      enabled: _prefs?.getBool('notif_$prayer') ?? false,
      minutesBefore: _prefs?.getInt('notif_${prayer}_before') ?? 0,
      sound: NotificationSound.values.firstWhere(
            (e) =>
        e.name ==
            (_prefs?.getString('notif_${prayer}_sound') ?? 'adhan'),
      ),
    );
  }
}
