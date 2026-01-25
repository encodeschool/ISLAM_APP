import 'dart:math';
import '../../models/learning/learning_item.dart';
import '../../models/learning/learning_step.dart';
import '../../models/learning/learning_activity_type.dart';

List<LearningStep> generateLessonSteps(List<LearningItem> items) {
  final random = Random();

  return items.map((item) {
    // Generate options
    final options = <String>{item.answer};
    while (options.length < 4) {
      options.add(items[random.nextInt(items.length)].answer);
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
