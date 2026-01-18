import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prayer_provider.dart';
import '../core/notification/notification_service.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

class PrayerPage extends StatelessWidget {
  const PrayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PrayerProvider>();

    if (provider.prayerTimes == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final prayers = [
      Prayer.fajr,
      Prayer.dhuhr,
      Prayer.asr,
      Prayer.maghrib,
      Prayer.isha,
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_left),
                onPressed: () => provider.changeDate(-1),
              ),
              Text(
                DateFormat.yMMMMd().format(provider.selectedDate),
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                onPressed: () => provider.changeDate(1),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: prayers.length,
            itemBuilder: (context, index) {
              final prayer = prayers[index];
              final time = provider.getPrayerTime(prayer);
              final isToday = DateUtils.isSameDay(
                provider.selectedDate,
                DateTime.now(),
              );

              final isActive =
                  isToday && prayer == provider.nextPrayer;

              return Container(
                decoration: BoxDecoration(
                  color: isActive ? Colors.green.shade900 : null,
                ),
                child: ListTile(
                  title: Text(
                    prayer.name.toUpperCase(),
                    style: TextStyle(
                      color: isActive ? Colors.white : null,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  leading: isActive
                      ? const Icon(Icons.access_time, color: Colors.white)
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat.Hm().format(time),
                        style: TextStyle(
                          color: isActive ? Colors.white : null,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: isActive ? Colors.white : null,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                              Text("Notification set for ${prayer.name}"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
