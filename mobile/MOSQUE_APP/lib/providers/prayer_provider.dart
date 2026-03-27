import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../core/notification/notification_service.dart';
import '../core/storage/local_storage.dart';
import '../models/prayer_notification_settings.dart';

class PrayerProvider extends ChangeNotifier {
  String locationName = "";
  bool isLocating = true;
  bool locationPermissionDenied = false;
  Map<Prayer, PrayerNotificationSettings> notificationSettings = {};

  DateTime currentTime = DateTime.now();

  PrayerTimes? prayerTimes;
  Duration timeLeft = Duration.zero;
  DateTime selectedDate = DateTime.now();
  Prayer? nextPrayer;

  Map<Prayer, int> manualOffsets = {
    Prayer.fajr: 0,
    Prayer.dhuhr: 0,
    Prayer.asr: 0,
    Prayer.maghrib: 0,
    Prayer.isha: 0,
  };

  void _loadNotificationSettings() {
    for (var prayer in Prayer.values) {
      notificationSettings[prayer] =
          LocalStorage.getPrayerNotification(prayer.name);
    }
  }

  void changeDate(int days) {
    selectedDate = selectedDate.add(Duration(days: days));

    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.hanafi;

    prayerTimes = PrayerTimes(
      prayerTimes!.coordinates,
      DateComponents.from(selectedDate),
      params,
    );

    notifyListeners();
  }

  Timer? _timer;

  PrayerProvider() {
    _init();
  }

  Future<void> _init() async {
    await _getLocation();
    _startClock();
    _loadOffsets();
    _loadNotificationSettings();
  }

  void _loadOffsets() {
    for (var prayer in Prayer.values) {
      manualOffsets[prayer] =
          LocalStorage.getOffset(prayer.name);
    }
  }

  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      currentTime = DateTime.now();
      _updateNextPrayer();
      notifyListeners();
    });
  }

  Future<void> _getLocation() async {
    isLocating = true;
    notifyListeners();

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationName = "";
      isLocating = false;
      notifyListeners();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      locationPermissionDenied = true;
      isLocating = false;
      notifyListeners();
      return;
    }

    final position = await Geolocator.getCurrentPosition();

    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      locationName =
      "${placemarks.first.locality}, ${placemarks.first.country}";
    } catch (_) {
      locationName = "";
    }

    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.hanafi;

    prayerTimes = PrayerTimes(
      Coordinates(position.latitude, position.longitude),
      DateComponents.from(selectedDate),
      params,
    );

    isLocating = false;
    _updateNextPrayer();
    notifyListeners();
  }

  DateTime getPrayerTime(Prayer prayer) {
    final baseTime = switch (prayer) {
      Prayer.fajr => prayerTimes!.fajr,
      Prayer.dhuhr => prayerTimes!.dhuhr,
      Prayer.asr => prayerTimes!.asr,
      Prayer.maghrib => prayerTimes!.maghrib,
      Prayer.isha => prayerTimes!.isha,
      _ => DateTime.now(),
    };

    return baseTime.add(
      Duration(minutes: manualOffsets[prayer] ?? 0),
    );
  }

  void setManualOffset(Prayer prayer, int minutes) {
    manualOffsets[prayer] = minutes;
    LocalStorage.setOffset(prayer.name, minutes);
    notifyListeners();
  }

  void _updateNextPrayer() {
    if (prayerTimes == null) return;

    final next = prayerTimes!.nextPrayer();
    if (next == Prayer.none) return;

    nextPrayer = next;
    final nextTime = getPrayerTime(next);
    timeLeft = nextTime.difference(currentTime);
  }

  void updatePrayerNotification(
      Prayer prayer,
      PrayerNotificationSettings settings,
      ) {
    notificationSettings[prayer] = settings;

    LocalStorage.setPrayerNotification(
      prayer.name,
      settings.enabled,
      settings.minutesBefore,
      settings.sound.name,
    );

    if (settings.enabled) {
      NotificationService.schedulePrayerNotification(
        prayer: prayer,
        time: getPrayerTime(prayer),
        minutesBefore: settings.minutesBefore,
        sound: settings.sound,
      );
    } else {
      NotificationService.cancelPrayerNotification(prayer);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
