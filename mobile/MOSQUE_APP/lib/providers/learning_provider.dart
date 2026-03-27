import 'package:flutter/material.dart';

import '../models/learning/learning_step.dart';
import '../models/learning/lesson.dart';

class LearningProvider extends ChangeNotifier {
  int xp = 0;
  int level = 1;
  int streak = 0;

  Lesson? currentLesson;
  int currentStepIndex = 0;

  LearningStep get currentStep => currentLesson!.steps[currentStepIndex];

  void nextStep() {
    if (currentStepIndex < currentLesson!.steps.length - 1) {
      currentStepIndex++;
      notifyListeners();
    } else {
      // Lesson completed
      lessonCompleted();
    }
  }

  void correctAnswer({int bonusXP = 10}) {
    xp += bonusXP;
    if (xp >= level * 100) level++;
    notifyListeners();
  }

  void lessonCompleted() {
    xp += 50;
    streak++;
    notifyListeners();
  }

  void startLesson(Lesson lesson) {
    Future.microtask(() {
      currentLesson = lesson;
      currentStepIndex = 0;
      notifyListeners();
    });
  }

  void wrongAnswer() {
    xp = (xp - 5).clamp(0, xp);
    notifyListeners();
  }

}
