import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../../widgets/learning/success_dialog.dart';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../../models/learning/arabic_letter.dart';
import '../../../../widgets/learning/success_dialog.dart';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../../widgets/learning/success_dialog.dart';
import '../../../../models/learning/arabic_letter.dart';

class CardMatchActivity extends StatefulWidget {
  final List<ArabicLetter> steps; // Pass ArabicLetter instead of String
  final VoidCallback onComplete;
  final VoidCallback onNext; // for next step

  const CardMatchActivity({
    super.key,
    required this.steps,
    required this.onComplete,
    required this.onNext,
  });

  @override
  State<CardMatchActivity> createState() => _CardMatchActivityState();
}

class _CardMatchActivityState extends State<CardMatchActivity> {
  late List<String> arabicCards;
  late List<String> englishCards;
  Map<String, bool> matched = {};

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    // Map ArabicLetter -> String
    arabicCards = widget.steps.map((e) => e.letter).toList()..shuffle();
    englishCards = widget.steps.map((e) => e.name).toList()..shuffle();

    matched = {for (var letter in widget.steps.map((e) => e.name)) letter: false};

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _checkComplete() {
    if (matched.values.every((v) => v)) {
      widget.onComplete();
      _confettiController.play();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => SuccessDialog(
          onContinue: () {
            Navigator.pop(context);
            widget.onNext(); // move to next activity
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Text(
                "Match Arabic → English",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Row(
                  children: [
                    // Arabic column
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: arabicCards.map((letter) {
                            if (matched.containsKey(letter) && matched[letter]!) {
                              return const SizedBox(height: 60);
                            }
                            return Container(
                              width: size.width / 2,
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Draggable<String>(
                                data: letter,
                                feedback: Material(
                                  child: Container(
                                    width: size.width / 2,
                                    color: Colors.green[900],
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                          letter,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                childWhenDragging: const SizedBox(height: 60),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                        letter,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 24
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    // English column
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: englishCards.map((name) {
                            return Container(
                              width: size.width / 2,
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: DragTarget<String>(
                                builder: (context, candidateData, rejectedData) {
                                  return Card(
                                    color: matched[name]! ? Colors.green : Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: matched[name]! ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                onWillAccept: (data) {
                                  final correctLetter = widget.steps
                                      .firstWhere((e) => e.name == name)
                                      .letter;
                                  return data == correctLetter;
                                },
                                onAccept: (data) {
                                  setState(() {
                                    matched[name] = true;
                                    _checkComplete();
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
