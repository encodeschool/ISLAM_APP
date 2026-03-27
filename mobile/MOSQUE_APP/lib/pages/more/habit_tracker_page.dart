import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/salah/salah_type.dart';
import '../../providers/salah_habit_provider.dart';
import '../../widgets/habitTracker/salah_habit_tile.dart';
import '../../widgets/habitTracker/score_card.dart';
import 'habitTracker/salah_analytics_page.dart';

class SalahHabitPage extends StatelessWidget {
  const SalahHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalahHabitProvider>();
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.habitTracker),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ───────────────── SCORE CARDS ─────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScoreCard(
                  title: t.today,
                  value: '${provider.todayScore} pts',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SalahAnalyticsPage(),
                      ),
                    );
                  },
                )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: -0.2),

                ScoreCard(
                  title: t.thisMonth,
                  value: '—',
                )
                    .animate()
                    .fadeIn(delay: 100.ms)
                    .slideY(begin: -0.2),

                ScoreCard(
                  title: t.rating,
                  value: 'Top 20%',
                )
                    .animate()
                    .fadeIn(delay: 200.ms)
                    .slideY(begin: -0.2),
              ],
            ),

            const SizedBox(height: 20),

            /// ───────────────── SWIPABLE AREA ─────────────────
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity == null) return;

                  HapticFeedback.lightImpact();

                  if (details.primaryVelocity! < 0) {
                    provider.changeDate(1);
                  } else {
                    provider.changeDate(-1);
                  }
                },
                child: Column(
                  children: [
                    /// DATE (ANIMATED)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.2, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        DateFormat.yMMMMd().format(provider.selectedDate),
                        key: ValueKey(provider.selectedDate),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// WEEK STRIP
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(7, (i) {
                          final weekDay = provider.selectedDate.subtract(
                            Duration(
                              days: provider.selectedDate.weekday - 1 - i,
                            ),
                          );

                          final isSelected = DateUtils.isSameDay(
                            weekDay,
                            provider.selectedDate,
                          );

                          return Column(
                            children: [
                              Text(
                                DateFormat.E().format(weekDay),
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 6),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.green
                                      : Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${weekDay.day}',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// SALAH LIST (ANIMATED)
                    Expanded(
                      child: ListView(
                        children: SalahType.values
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final salah = entry.value;

                          return SalahHabitTile(
                            salah: salah,
                            title: salah.label(t),
                          )
                              .animate()
                              .fadeIn(
                            duration: 300.ms,
                            delay: (index * 80).ms,
                          )
                              .slideX(begin: 0.1);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ───────────────── LOCALIZATION EXTENSION ─────────────────

extension SalahLocalization on SalahType {
  String label(AppLocalizations t) {
    switch (this) {
      case SalahType.fajr:
        return t.fajr;
      case SalahType.dhuhr:
        return t.dhuhr;
      case SalahType.asr:
        return t.asr;
      case SalahType.maghrib:
        return t.maghrib;
      case SalahType.isha:
        return t.isha;
    }
  }
}
