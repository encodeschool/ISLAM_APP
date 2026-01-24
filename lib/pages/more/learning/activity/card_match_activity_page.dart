import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../../widgets/learning/success_dialog.dart';

class CardMatchActivity extends StatefulWidget {
  final List<String> steps; // Arabic letter names
  final VoidCallback onComplete;
  final VoidCallback onNext; // <-- for next step

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
    arabicCards = List.from(widget.steps)..shuffle();
    englishCards = List.from(widget.steps)..shuffle();
    matched = {for (var step in widget.steps) step: false};

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
            widget.onNext(); // move to next learning activity
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Match Arabic → English",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Row(
                  children: [
                    // Arabic column
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: arabicCards.map((letter) {
                          if (matched[letter]!) return const SizedBox(height: 60);
                          return Draggable<String>(
                            data: letter,
                            feedback: Material(
                              child: Card(
                                color: Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(letter,
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.white)),
                                ),
                              ),
                            ),
                            childWhenDragging: const SizedBox(height: 60),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(letter,
                                    style: const TextStyle(fontSize: 24)),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // English column
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: englishCards.map((letter) {
                          return DragTarget<String>(
                            builder: (context, candidateData, rejectedData) {
                              return Card(
                                color: matched[letter]! ? Colors.green : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    letter,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: matched[letter]! ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                            onWillAccept: (data) => data == letter,
                            onAccept: (data) {
                              setState(() {
                                matched[letter] = true;
                                _checkComplete();
                              });
                            },
                          );
                        }).toList(),
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
