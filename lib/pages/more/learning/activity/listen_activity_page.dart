import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:mosque/models/learning/learning_item.dart';
import '../../../../models/learning/arabic_letter.dart';
import '../../../../widgets/learning/answer_button.dart';
import '../../../../widgets/learning/success_dialog.dart';
import 'package:audioplayers/audioplayers.dart';

class ListenActivity extends StatefulWidget {
  final LearningItem item;
  final List<String> options;
  final VoidCallback onCorrect;
  final VoidCallback onNext; // <-- new callback for next step
  final VoidCallback onWrong;

  const ListenActivity({
    super.key,
    required this.item,
    required this.options,
    required this.onCorrect,
    required this.onNext,
    required this.onWrong
  });

  @override
  State<ListenActivity> createState() => _ListenActivityState();
}

class _ListenActivityState extends State<ListenActivity> {
  bool answered = false;
  late ConfettiController _confettiController;
  bool isWrong = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    Future.delayed(const Duration(milliseconds: 400), _playSound);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _handleAnswer(String option) {
    if (answered) return;

    final isCorrect = option == widget.item.answer;
    setState(() {
      answered = true;
    });

    if (isCorrect) {
      widget.onCorrect();
      _confettiController.play();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => SuccessDialog(
          onContinue: () {
            Navigator.pop(context);
            widget.onNext();
          },
        ),
      );
    } else {
      setState(() {
        isWrong = true;
      });
      widget.onWrong();
    }
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setReleaseMode(ReleaseMode.stop);
      await _audioPlayer.play(
        AssetSource(widget.item.audio),
        volume: 1.0,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Audio not available")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.item.display,
                        style: TextStyle(
                            fontSize: 48
                        ),
                      ),
                      IconButton(
                        iconSize: 24,
                        icon: const Icon(Icons.volume_up),
                        onPressed: _playSound,
                      ),
                      const SizedBox(height: 12),
                      ...widget.options.map(
                            (option) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: AnswerButton(
                            text: option,
                            isCorrect: option == widget.item.answer,
                            disabled: answered,
                            onTap: () => _handleAnswer(option),
                          ),
                        ),
                      ),
                      if (answered && isWrong)
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 24),
                          child: ElevatedButton(
                            onPressed: widget.onNext,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[900],
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
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
      ),
    );
  }
}
