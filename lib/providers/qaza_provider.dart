import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QazaProvider extends ChangeNotifier {
  DateTime? startDate;
  DateTime endDate = DateTime.now();
  bool get datesSelected => startDate != null && endDate != null;

  final Map<Prayer, int> remaining = {
    Prayer.fajr: 0,
    Prayer.dhuhr: 0,
    Prayer.asr: 0,
    Prayer.maghrib: 0,
    Prayer.isha: 0,
  };

  QazaProvider() {
    _load();
  }

  int get totalRemaining =>
      remaining.values.fold(0, (a, b) => a + b);

  void calculate() {
    if (startDate == null) return;

    final days =
        endDate.difference(startDate!).inDays + 1;

    for (final key in remaining.keys) {
      remaining[key] = days;
    }

    _save();
    notifyListeners();
  }

  void markDone(Prayer prayer) {
    if (remaining[prayer]! > 0) {
      remaining[prayer] = remaining[prayer]! - 1;
      _save();
      notifyListeners();
    }
  }

  void reset() {
    startDate = null;
    for (final key in remaining.keys) {
      remaining[key] = 0;
    }
    _save();
    notifyListeners();
  }

  // 💾 Persistence
  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();

    if (startDate != null) {
      prefs.setString('qaza_start', startDate!.toIso8601String());
    }

    for (final key in remaining.keys) {
      prefs.setInt('qaza_${key.name}', remaining[key]!);
    }
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();

    final start = prefs.getString('qaza_start');
    if (start != null) {
      startDate = DateTime.parse(start);
    }

    for (final key in remaining.keys) {
      remaining[key] = prefs.getInt('qaza_${key.name}') ?? 0;
    }

    notifyListeners();
  }
}
