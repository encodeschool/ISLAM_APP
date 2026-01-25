import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/learning/prayer_words.dart';
import '../../../models/learning/lesson.dart';
import '../../../providers/learning_provider.dart';
import '../../../utils/learning/lesson_generator.dart';
import '../../../widgets/learning/xp_bar.dart';

import 'learning_step_page.dart';

class PrayerWordsPage extends StatefulWidget {
  const PrayerWordsPage({super.key});

  @override
  State<PrayerWordsPage> createState() => _PrayerWordsPageState();
}

class _PrayerWordsPageState extends State<PrayerWordsPage> {
  @override
  void initState() {
    super.initState();

    final steps = generateLessonSteps(prayerWords);

    context.read<LearningProvider>().startLesson(
      Lesson(
        title: 'Prayer Words',
        steps: steps,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final learning = context.watch<LearningProvider>();

    if (learning.currentLesson == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Words'),
      ),
      body: Column(
        children: [
          XPBar(
            xp: learning.xp,
            level: learning.level,
          ),
          const Expanded(
            child: LearningStepPage(),
          ),
        ],
      ),
    );
  }
}
