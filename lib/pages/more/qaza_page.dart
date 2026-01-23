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
        scrolledUnderElevation: 0,
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
                onPressed: qaza.datesSelected ? qaza.calculate : null,
                child: Text(
                    t.calculate_qaza,
                    style: TextStyle(
                      color: Colors.green[500]
                    ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.green[50],
                  side: BorderSide(
                    color: Color(0xFF4BAE4F),
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

              if (!qaza.datesSelected)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    t.select_start_and_end_dates,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              else
                Column(
                  children: qaza.remaining.entries.map((entry) {
                    return Card(
                      elevation: 1,
                      child: ListTile(
                        enabled: entry.value > 0,
                        title: Text(entry.key.localizedName(t)),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            color: entry.value > 0
                                ? Colors.green[400]
                                : Colors.grey,
                          ),
                          onPressed: entry.value > 0
                              ? () => qaza.markDone(entry.key)
                              : null,
                        ),
                        onTap: entry.value > 0
                            ? () => qaza.markDone(entry.key)
                            : null,
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
                    onPressed: qaza.datesSelected ? qaza.reset : null,
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
