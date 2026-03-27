enum NotificationSound {
  adhan,
  simple,
  silent,
}

class PrayerNotificationSettings {
  final bool enabled;
  final int minutesBefore;
  final NotificationSound sound;

  const PrayerNotificationSettings({
    required this.enabled,
    required this.minutesBefore,
    required this.sound,
  });

  PrayerNotificationSettings copyWith({
    bool? enabled,
    int? minutesBefore,
    NotificationSound? sound,
  }) {
    return PrayerNotificationSettings(
      enabled: enabled ?? this.enabled,
      minutesBefore: minutesBefore ?? this.minutesBefore,
      sound: sound ?? this.sound,
    );
  }
}
