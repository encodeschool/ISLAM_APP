import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:mosque/models/learning/learning_item.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/learning/arabic_letter.dart';
import '../../../../widgets/learning/success_dialog.dart';

class WriteLetterActivity extends StatefulWidget {
  final LearningItem item;
  final VoidCallback onCorrect;
  final VoidCallback onNext; // go to next step

  const WriteLetterActivity({
    super.key,
    required this.item,
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

  void _checkAnswer(AppLocalizations t) {
    if (answered) return;

    if (controller.text.trim().toLowerCase() ==
        widget.item.answer.toLowerCase()) {
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
      // Show error feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.incorrect)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.item.display,
              style: const TextStyle(fontSize: 80, fontFamily: 'Amiri'),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: controller,
                onSubmitted: (_) => _checkAnswer(t),
                decoration: InputDecoration(
                  hintText: t.typeTheAnswer,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              // Pass the localization object
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[50],
                side: BorderSide(
                  color: Colors.green.shade900
                )
              ),
              onPressed: () => _checkAnswer(t),
              child: Text(
                  t.submit,
                  style: TextStyle(
                    color: Colors.green[900]
                  ),
              ),
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
