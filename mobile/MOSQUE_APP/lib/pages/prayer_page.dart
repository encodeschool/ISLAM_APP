import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/prayer_notification_settings.dart';
import '../providers/prayer_provider.dart';
import '../core/notification/notification_service.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

class PrayerPage extends StatelessWidget {
  const PrayerPage({super.key});

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    return "${h.toString().padLeft(2, '0')}:"
        "${m.toString().padLeft(2, '0')}:"
        "${s.toString().padLeft(2, '0')}";
  }

  void showPrayerNotificationModal(
      BuildContext context,
      Prayer prayer,
      ) {
    final provider = context.read<PrayerProvider>();
    var settings = provider.notificationSettings[prayer]!;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text("Enable notification"),
                    value: settings.enabled,
                    onChanged: (v) {
                      setState(() {
                        settings = settings.copyWith(enabled: v);
                      });
                    },
                  ),

                  if (settings.enabled) ...[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'At what time?'
                          ),
                          DropdownButton<int>(
                            value: settings.minutesBefore,
                            items: const [
                              DropdownMenuItem(value: 0, child: Text("At time")),
                              DropdownMenuItem(value: 5, child: Text("5 minutes before")),
                              DropdownMenuItem(value: 10, child: Text("10 minutes before")),
                              DropdownMenuItem(value: 15, child: Text("15 minutes before")),
                            ],
                            onChanged: (v) {
                              setState(() {
                                settings = settings.copyWith(minutesBefore: v!);
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          left: 15,
                          right: 15
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'What sound?'
                          ),
                          DropdownButton<NotificationSound>(
                            value: settings.sound,
                            items: const [
                              DropdownMenuItem(
                                value: NotificationSound.adhan,
                                child: Text("Adhan"),
                              ),
                              DropdownMenuItem(
                                value: NotificationSound.simple,
                                child: Text("Simple"),
                              ),
                              DropdownMenuItem(
                                value: NotificationSound.silent,
                                child: Text("Silent"),
                              ),
                            ],
                            onChanged: (v) {
                              setState(() {
                                settings = settings.copyWith(sound: v!);
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],

                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: () {
                      provider.updatePrayerNotification(prayer, settings);
                      Navigator.pop(context);
                    },
                    child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.green[900]
                        ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.green[50],
                      side: BorderSide(
                        color: Color(0xFF4BAE4F),
                        width: 2
                      )
                    )
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final provider = context.watch<PrayerProvider>();
    final locale = Localizations.localeOf(context).languageCode;
    final formattedDate = DateFormat.yMMMMd(locale).format(provider.selectedDate);
    final prayerProvider = context.watch<PrayerProvider>();

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

    String getPrayerName(Prayer prayer, AppLocalizations t) {
      switch (prayer) {
        case Prayer.fajr:
          return t.prayerFajr;
        case Prayer.dhuhr:
          return t.prayerDhuhr;
        case Prayer.asr:
          return t.prayerAsr;
        case Prayer.maghrib:
          return t.prayerMaghrib;
        case Prayer.isha:
          return t.prayerIsha;
        default:
          return prayer.name;
      }
    }

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
                DateFormat.yMMMMd(Localizations.localeOf(context).languageCode)
                    .format(provider.selectedDate),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
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

              final notif = provider.notificationSettings[prayer];

              return Container(
                decoration: BoxDecoration(
                  color: isActive ? Colors.green.shade900 : null,
                ),
                child: ListTile(
                  title: Text(
                    getPrayerName(prayer, t),
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
                      if (isActive)
                        Text(
                          '-${_formatDuration(prayerProvider.timeLeft)}',
                          style: TextStyle(
                            color: isActive ? Colors.white : null,
                          ),
                        ),
                      SizedBox(width: 35),
                      Text(
                        DateFormat.Hm().format(time),
                        style: TextStyle(
                          color: isActive ? Colors.white : null,
                        ),
                      ),

                      IconButton(
                        icon: Icon(
                          notif?.enabled == true
                              ? Icons.notifications_active
                              : Icons.notifications_off,
                          color: isActive ? Colors.white : null,
                        ),
                        onPressed: () => showPrayerNotificationModal(context, prayer),
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
