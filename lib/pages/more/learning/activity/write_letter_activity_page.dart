import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../../models/learning/arabic_letter.dart';
import '../../../../widgets/learning/success_dialog.dart';

class WriteLetterActivity extends StatefulWidget {
  final ArabicLetter letter;
  final VoidCallback onCorrect;
  final VoidCallback onNext; // <-- new callback to go to next step

  const WriteLetterActivity({
    super.key,
    required this.letter,
    required this.onCorrect,
    required this.onNext,
  });

  @override
  State<WriteLetterActivity> createState() => _WriteLetterActivityState();
}

class _WriteLetterActivityState extends State<WriteLetterActivity> {
  final controller = TextEditingController();
  bool answered = false;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _checkAnswer() {
    if (answered) return;

    if (controller.text.trim().toLowerCase() ==
        widget.letter.name.toLowerCase()) {
      setState(() => answered = true);

      widget.onCorrect();
      _confettiController.play();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => SuccessDialog(
          onContinue: () {
            Navigator.pop(context); // close dialog
            widget.onNext(); // go to next activity
          },
        ),
      );
    } else {
      // Optional: show error feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect! Try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.letter.letter,
              style: const TextStyle(fontSize: 80, fontFamily: 'Amiri'),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: controller,
                onSubmitted: (_) => _checkAnswer(),
                decoration: const InputDecoration(
                  hintText: 'Type the name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: const Text("Submit"),
            ),
          ],
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
