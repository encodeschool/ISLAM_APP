import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/learning/lesson_type.dart';
import '../../../providers/learning_provider.dart';
import '../../../widgets/learning/lesson_card.dart';
import '../../../widgets/learning/xp_bar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/learning_provider.dart';
import '../../../widgets/learning/xp_bar.dart';

class LearningHomePage extends StatelessWidget {
  const LearningHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final learning = context.watch<LearningProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Learn Arabic"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          XPBar(xp: learning.xp, level: learning.level),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                LessonCard(
                  title: "Arabic Letters",
                  subtitle: "Alif → Ya",
                  icon: Icons.sort_by_alpha,
                  color: Color(0xFF2E7D32),
                  type: LessonType.letters,
                ),
                LessonCard(
                  title: "Basic Words",
                  subtitle: "Everyday Arabic",
                  icon: Icons.translate,
                  color: Color(0xFF1565C0),
                  type: LessonType.basicWords,
                ),
                LessonCard(
                  title: "Prayer Words",
                  subtitle: "Islamic vocabulary",
                  icon: Icons.mosque,
                  color: Color(0xFF6A1B9A),
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
