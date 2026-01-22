import 'package:flutter/material.dart';
import 'package:mosque/core/localization/prayer_localization.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/qaza_provider.dart';

class QazaPage extends StatelessWidget {
  const QazaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final qaza = context.watch<QazaProvider>();
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.qaza_prayers),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _dateTile(
                      t,
                      context,
                      title: t.start_date,
                      date: qaza.startDate,
                      onPick: (d) => qaza.startDate = d,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _dateTile(
                      t,
                      context,
                      title: t.end_date,
                      date: qaza.endDate,
                      onPick: (d) => qaza.endDate = d,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: qaza.calculate,
                child: Text(
                    t.calculate_qaza,
                    style: TextStyle(
                      color: Colors.green[900]
                    ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[50],
                  side: BorderSide(
                    color: Color(0xFF1B5D20),
                    width: 2
                  ),
                ),
              ),

              const SizedBox(height: 16),

              if (qaza.totalRemaining > 0)
                Text(
                  "${t.total_remaining}: ${qaza.totalRemaining}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              const SizedBox(height: 16),

              Column(
                children: qaza.remaining.entries.map((entry) {
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      title: Text(entry.key.localizedName(t)),
                      trailing: IconButton(
                        icon: Icon(
                            Icons.check_circle,
                            color: Colors.green[400],
                        ),
                        onPressed: entry.value > 0
                            ? () => qaza.markDone(entry.key)
                            : null,
                      ),
                      onTap: () => qaza.markDone(entry.key),
                    ),
                  );
                }).toList(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                      Icons.refresh,
                      color: Colors.blue,
                  ),
                  TextButton(
                    onPressed: qaza.reset,
                    child: Text(
                        t.reset,
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateTile(
      AppLocalizations t,
      BuildContext context, {
        required String title,
        required DateTime? date,
        required Function(DateTime) onPick,
      }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        date == null
            ? t.select
            : DateFormat.yMMMd().format(date),
      ),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
        );

        if (picked != null) {
          onPick(picked);
        }
      },
    );
  }
}
