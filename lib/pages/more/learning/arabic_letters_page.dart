import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../../data/learning/arabic_letters.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/learning/arabic_letter.dart';
import '../../../models/learning/learning_activity_type.dart';
import '../../../models/learning/learning_item.dart';
import '../../../models/learning/learning_step.dart';
import '../../../models/learning/lesson.dart';
import '../../../providers/learning_provider.dart';
import '../../../widgets/learning/xp_bar.dart';
import 'learning_step_page.dart';

class ArabicLettersPage extends StatefulWidget {
  const ArabicLettersPage({super.key});

  @override
  State<ArabicLettersPage> createState() => _ArabicLettersPageState();
}

class _ArabicLettersPageState extends State<ArabicLettersPage> {
  late List<LearningStep> lessonSteps;

  @override
  void initState() {
    super.initState();
    _generateLesson();
    final learning = context.read<LearningProvider>();
    learning.startLesson(
      Lesson(title: "Arabic Letters", steps: lessonSteps),
    );
  }

  void _generateLesson() {
    lessonSteps = arabicLetters.map((letter) {
      final item = LearningItem(
        id: letter.id,
        display: letter.letter,
        answer: letter.name,
        audio: letter.sound,
      );

      // generate options
      final options = <String>{item.answer};
      final random = Random();

      while (options.length < 4) {
        options.add(
          arabicLetters[random.nextInt(arabicLetters.length)].name,
        );
      }

      final shuffledOptions = options.toList()..shuffle();

      return [
        LearningStep(
          type: LearningActivityType.multipleChoice,
          item: item,
          options: shuffledOptions,
        ),
        LearningStep(
          type: LearningActivityType.write,
          item: item,
        ),
        LearningStep(
          type: LearningActivityType.listen,
          item: item,
          options: shuffledOptions,
        ),
        LearningStep(
          type: LearningActivityType.cardMatch,
          item: item,
        ),
      ];
    }).expand((e) => e).toList();
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
          t.arabicLetter
        ),
      ),
      body: Column(
        children: [
          // XP bar
          XPBar(
            xp: learning.xp,
            level: learning.level,
          ),
          Expanded(
            child: LearningStepPage(), // renders the current step dynamically
          ),
        ],
      ),
    );
  }
}
