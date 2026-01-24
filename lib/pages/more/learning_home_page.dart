import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/learning/lesson_type.dart';
import '../../providers/learning_provider.dart';
import '../../widgets/learning/lesson_card.dart';
import '../../widgets/learning/xp_bar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/learning_provider.dart';
import '../../widgets/learning/xp_bar.dart';

class LearningHomePage extends StatelessWidget {
  const LearningHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final learning = context.watch<LearningProvider>();
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.learnArabic
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                LessonCard(
                  title: t.arabicLetter,
                  subtitle: "Alif → Ya",
                  icon: Icons.sort_by_alpha,
                  color: Colors.white,
                  // color: Color(0xFF2E7D32),
                  type: LessonType.letters,
                ),
                LessonCard(
                  title: t.basicWords,
                  subtitle: t.everyDayArabic,
                  icon: Icons.translate,
                  color: Colors.white,
                  // color: Color(0xFF1565C0),
                  type: LessonType.basicWords,
                ),
                LessonCard(
                  title: t.prayerWords,
                  subtitle: t.islamicWords,
                  icon: Icons.mosque,
                  color: Colors.white,
                  // color: Color(0xFF6A1B9A),
                  type: LessonType.prayerWords,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
