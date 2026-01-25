import 'package:mosque/models/learning/learning_item.dart';

import 'arabic_letter.dart';
import 'learning_activity_type.dart';

class LearningStep {
  final LearningActivityType type;
  final LearningItem item;
  final List<String>? options;

  LearningStep({
    required this.type,
    required this.item,
    this.options,
  });
}
