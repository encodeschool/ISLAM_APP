// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// class NotificationService {
//   static final _notifications = FlutterLocalNotificationsPlugin();
//
//   static Future<void> init() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android);
//     await _notifications.initialize(settings);
//   }
//
//   static Future<void> schedulePrayerNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime time,
//   }) async {
//     final now = tz.TZDateTime.now(tz.local);
//
//     var scheduledDate = tz.TZDateTime.from(time, tz.local);
//
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//
//     await _notifications.zonedSchedule(
//       id,
//       title,
//       body,
//       scheduledDate,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'prayer_channel',
//           'Prayer Notifications',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//       ),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
//
//   static Future<void> cancel(int id) async {
//     await _notifications.cancel(id);
//   }
// }
