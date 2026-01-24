import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:adhan/adhan.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../models/prayer_notification_settings.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  // Keep track of which prayers have notifications
  static final Map<Prayer, bool> _scheduled = {};

  static Future<void> init() async {
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _notifications.initialize(settings);
  }

  static Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    const android = AndroidNotificationDetails(
      'general_channel',
      'General Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const ios = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: android,
      iOS: ios,
    );

    await _notifications.show(
      0,
      title,
      body,
      details,
    );
  }

  static bool isScheduled(Prayer prayer) {
    return _scheduled[prayer] ?? false;
  }

  static Future<void> schedulePrayerNotification({
    required Prayer prayer,
    required DateTime time,
    required int minutesBefore,
    required NotificationSound sound,
  }) async {
    final scheduledTime = time.subtract(Duration(minutes: minutesBefore));

    final androidDetails = AndroidNotificationDetails(
      'prayer_channel',
      'Prayer Notifications',
      sound: sound == NotificationSound.adhan
          ? const RawResourceAndroidNotificationSound('adhan')
          : null,
      playSound: sound != NotificationSound.silent,
    );

    await _notifications.zonedSchedule(
      prayer.index,
      prayer.name,
      "Time for ${prayer.name}",
      tz.TZDateTime.from(scheduledTime, tz.local),
      NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> cancelPrayerNotification(Prayer prayer) async {
    await _notifications.cancel(prayer.index);
    _scheduled[prayer] = false;
  }

}
