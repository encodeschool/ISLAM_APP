import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../core/storage/local_storage.dart';

class PrayerProvider extends ChangeNotifier {
  String locationName = "Locating...";
  DateTime currentTime = DateTime.now();

  PrayerTimes? prayerTimes;
  String nextPrayerName = "";
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
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition();

    final placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    locationName =
    "${placemarks.first.locality}, ${placemarks.first.country}";

    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.hanafi;

    prayerTimes = PrayerTimes(
      Coordinates(position.latitude, position.longitude),
      DateComponents.from(DateTime.now()),
      params,
    );

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
    nextPrayerName = next.name.toUpperCase();
    final nextTime = getPrayerTime(next);

    // DateTime nextTime;
    // switch (next) {
    //   case Prayer.fajr:
    //     nextTime = prayerTimes!.fajr;
    //     break;
    //   case Prayer.dhuhr:
    //     nextTime = prayerTimes!.dhuhr;
    //     break;
    //   case Prayer.asr:
    //     nextTime = prayerTimes!.asr;
    //     break;
    //   case Prayer.maghrib:
    //     nextTime = prayerTimes!.maghrib;
    //     break;
    //   case Prayer.isha:
    //     nextTime = prayerTimes!.isha;
    //     break;
    //   default:
    //     return;
    // }

    timeLeft = nextTime.difference(currentTime);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
