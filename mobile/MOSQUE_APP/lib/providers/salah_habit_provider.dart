import 'package:flutter/material.dart';
import '../models/salah/salah_habit.dart';
import '../models/salah/salah_type.dart';

class SalahHabitProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();

  final Map<String, SalahHabit> _habits = {};

  String _key(SalahType salah, DateTime date) =>
      '${salah.name}_${date.toIso8601String().substring(0, 10)}';

  SalahHabit getHabit(SalahType salah, DateTime date) {
    return _habits[_key(salah, date)] ??
        SalahHabit(
          salah: salah,
          date: date,
          status: SalahStatus.notPrayed,
        );
  }

  void updateHabit(
      SalahType salah,
      DateTime date,
      SalahStatus status,
      ) {
    _habits[_key(salah, date)] = SalahHabit(
      salah: salah,
      date: date,
      status: status,
    );
    notifyListeners();
  }

  int get todayScore {
    final today = DateTime.now();
    return SalahType.values
        .map((s) => getHabit(s, today).score)
        .fold(0, (a, b) => a + b);
  }

  void changeDate(int days) {
    selectedDate = selectedDate.add(Duration(days: days));
    notifyListeners();
  }
}
