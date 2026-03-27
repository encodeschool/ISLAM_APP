import 'package:flutter/material.dart';
import 'package:mosque/data/allah_names.dart';
import 'package:mosque/models/allah_name.dart';

class DailyCardProvider extends ChangeNotifier {
  late AllahName todayName;

  DailyCardProvider() {
    _calculateToday();
  }

  void _calculateToday() {
    final now = DateTime.now();
    final start = DateTime(2024, 1, 1);
    final dayIndex = now.difference(start).inDays;

    todayName = allahNames[dayIndex % allahNames.length];
  }
}
