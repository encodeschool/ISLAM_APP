import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/learning/arabic_letters.dart';
import '../../../models/learning/arabic_letter.dart';
import '../../../models/learning/learning_activity_type.dart';
import '../../../providers/learning_provider.dart';
import 'activity/card_match_activity_page.dart';
import 'activity/listen_activity_page.dart';
import 'activity/multiple_choice_activity_page.dart';
import 'activity/write_letter_activity_page.dart';

class LearningStepPage extends StatelessWidget {
  const LearningStepPage({super.key});

  @override
  Widget build(BuildContext context) {
    final learning = context.watch<LearningProvider>();
    final step = learning.currentStep;

    switch (step.type) {
      case LearningActivityType.multipleChoice:
        return MultipleChoiceActivity(
          item: step.item,
          options: step.options!,
          onCorrect: learning.correctAnswer,
          onNext: learning.nextStep,
        );

      case LearningActivityType.write:
        return WriteLetterActivity(
          item: step.item,
          onCorrect: learning.correctAnswer,
          onNext: learning.nextStep,
        );

      case LearningActivityType.listen:
        return ListenActivity(
          item: step.item,
          options: step.options!,
          onCorrect: learning.correctAnswer,
          onNext: learning.nextStep,
        );

      case LearningActivityType.cardMatch:
        return CardMatchActivity(
          items: learning.currentLesson!.steps
              .map((s) => s.item)
              .toSet()
              .toList(),
          onComplete: learning.correctAnswer,
          onNext: learning.nextStep,
        );
    }
  }
}
