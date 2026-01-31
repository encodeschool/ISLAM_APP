import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/learning/basic_words.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/learning/lesson.dart';
import '../../../providers/learning_provider.dart';
import '../../../utils/learning/lesson_generator.dart';
import '../../../widgets/learning/xp_bar.dart';
import 'learning_step_page.dart';

class BasicWordsPage extends StatefulWidget {
  const BasicWordsPage({super.key});

  @override
  State<BasicWordsPage> createState() => _BasicWordsPageState();
}

class _BasicWordsPageState extends State<BasicWordsPage> {
  @override
  void initState() {
    super.initState();

    final steps = generateLessonSteps(basicWords);

    context.read<LearningProvider>().startLesson(
      Lesson(
        title: 'Basic Words',
        steps: steps,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final learning = context.watch<LearningProvider>();
    final t = AppLocalizations.of(context)!;

    if (learning.currentLesson == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.basicWords
        ),
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
