import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/salah/salah_habit.dart';
import '../../models/salah/salah_type.dart';
import '../../providers/salah_habit_provider.dart';


class SalahHabitTile extends StatelessWidget {
  final SalahType salah;
  final String title;

  const SalahHabitTile({super.key, required this.salah, required this.title});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalahHabitProvider>();
    final habit = provider.getHabit(salah, provider.selectedDate);

    Color bg;
    IconData? icon;

    switch (habit.status) {
      case SalahStatus.prayedInMosque:
        bg = Colors.green;
        icon = Icons.mosque;
        break;
      case SalahStatus.prayedInJamaah:
        bg = Colors.lightGreen;
        icon = Icons.groups;
        break;
      case SalahStatus.prayedAlone:
        bg = Colors.orange;
        icon = Icons.person;
        break;
      default:
        bg = Colors.grey.shade200;
    }

    return GestureDetector(
      onTap: () => _showBottomSheet(context, provider),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (icon != null) Icon(icon),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, SalahHabitProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: SalahStatus.values.map((s) {
          return ListTile(
            title: Text(s.name),
            onTap: () {
              provider.updateHabit(
                salah,
                provider.selectedDate,
                s,
              );
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}
