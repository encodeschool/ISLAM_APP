import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mosque/models/learning/learning_item.dart';
import '../../../../models/learning/arabic_letter.dart';
import '../../../../widgets/learning/answer_button.dart';
import '../../../../widgets/learning/success_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../../../../models/learning/arabic_letter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../../../../models/learning/arabic_letter.dart';

class MultipleChoiceActivity extends StatefulWidget {
  final LearningItem item;
  final List<String> options;
  final VoidCallback onCorrect;
  final VoidCallback onNext; // <-- callback to go to next letter/activity

  const MultipleChoiceActivity({
    super.key,
    required this.item,
    required this.options,
    required this.onCorrect,
    required this.onNext,
  });

  @override
  State<MultipleChoiceActivity> createState() =>
      _MultipleChoiceActivityState();
}

class _MultipleChoiceActivityState extends State<MultipleChoiceActivity> {
  bool answered = false;
  String? selectedOption;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _handleAnswer(String option) {
    if (answered) return;

    setState(() {
      answered = true;
      selectedOption = option;
    });

    final isCorrect = option == widget.item.answer;

    if (isCorrect) {
      widget.onCorrect(); // add XP / mark correct
      _confettiController.play(); // show confetti

      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => SuccessDialog(
          onContinue: () {
            Navigator.pop(context); // close dialog
            widget.onNext(); // move to next letter/activity
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Display letter
          Text(
            widget.item.display,
            style: const TextStyle(fontSize: 80, fontFamily: 'Amiri'),
          ),
          const SizedBox(height: 24),
          ...widget.options.map((option) {
            return AnswerButton(
              text: option,
              isCorrect: option == widget.item.answer,
              disabled: answered,
              onTap: () => _handleAnswer(option),
            );
          }),
          // Confetti widget overlay
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 20,
              minBlastForce: 5,
            ),
          ),
        ],
      ),
    );
  }
}
