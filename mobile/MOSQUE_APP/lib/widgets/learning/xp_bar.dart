import 'package:flutter/material.dart';

class XPBar extends StatelessWidget {
  final int xp;
  final int level;

  const XPBar({super.key, required this.xp, required this.level});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text("Lv $level"),
          const SizedBox(width: 12),
          Expanded(
            child: LinearProgressIndicator(
              color: Colors.green[900],
              backgroundColor: Colors.green.shade50,
              value: xp / (level * 100),
            ),
          ),
          const SizedBox(width: 12),
          Text("$xp XP"),
        ],
      ),
    );
  }
}
