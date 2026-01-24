import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  final ArabicLetter letter;
  final List<String> options;
  final VoidCallback onCorrect;
  final VoidCallback onNext; // <-- callback to go to next letter/activity

  const MultipleChoiceActivity({
    super.key,
    required this.letter,
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

    final isCorrect = option == widget.letter.name;

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
    return Column(
      children: [
        // Display letter
        Text(
          widget.letter.letter,
          style: const TextStyle(fontSize: 80, fontFamily: 'Amiri'),
        ),
        const SizedBox(height: 24),
        ...widget.options.map((option) {
          final isCorrect = option == widget.letter.name;
          final isSelected = option == selectedOption;
          Color? color = Colors.green.shade50;

          if (answered) {
            if (isSelected) {
              color = isCorrect ? Colors.green[900] : Colors.red;
            } else if (isCorrect) {
              color = Colors.green[900];
            }
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: GestureDetector(
              onTap: () => _handleAnswer(option),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade900),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).animate().scale(
                  duration: 300.ms,
                  curve: Curves.easeOut,
                ),
              ),
            ),
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
    );
  }
}
