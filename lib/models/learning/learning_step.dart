import 'arabic_letter.dart';
import 'learning_activity_type.dart';

class LearningStep {
  final LearningActivityType type;
  final ArabicLetter letter; // Or word
  final List<String>? options; // For multiple choice / match
  final String? audioPath;     // For listen activities

  LearningStep({
    required this.type,
    required this.letter,
    this.options,
    this.audioPath,
  });
}
