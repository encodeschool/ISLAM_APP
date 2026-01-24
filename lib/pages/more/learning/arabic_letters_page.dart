import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../../data/learning/arabic_letters.dart';
import '../../../models/learning/arabic_letter.dart';
import '../../../models/learning/learning_activity_type.dart';
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
      // Generate multiple choice options
      List<String> options = [letter.name];
      while (options.length < 4) {
        final option = arabicLetters[Random().nextInt(arabicLetters.length)].name;
        if (!options.contains(option)) options.add(option);
      }
      options.shuffle();

      // Each letter lesson: multiple choice → write → listen → card match
      return [
        LearningStep(
          type: LearningActivityType.multipleChoice,
          letter: letter,
          options: options,
        ),
        LearningStep(
          type: LearningActivityType.write,
          letter: letter,
        ),
        LearningStep(
          type: LearningActivityType.listen,
          letter: letter,
          options: options,
        ),
        LearningStep(
          type: LearningActivityType.cardMatch,
          letter: letter,
          options: options,
        ),
      ];
    }).expand((step) => step).toList();
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
        title: const Text("Arabic Letters"),
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
