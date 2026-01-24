import 'package:flutter/material.dart';

import 'package:confetti/confetti.dart';

import '../../l10n/app_localizations.dart';

class SuccessDialog extends StatefulWidget {
  final VoidCallback onContinue;

  const SuccessDialog({
    super.key,
    required this.onContinue,
  });

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 2));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Stack(
      children: [
        AlertDialog(
          title: Text(
            t.correct
          ),
          content: const Text("+10 XP"),
          actions: [
            TextButton(
              onPressed: widget.onContinue,
              child: Text(
                t.continueBtn
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _controller,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ),
      ],
    );
  }
}
