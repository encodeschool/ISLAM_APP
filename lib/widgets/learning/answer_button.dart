import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final bool isCorrect;
  final bool disabled;
  final VoidCallback? onTap;

  const AnswerButton({
    super.key,
    required this.text,
    required this.isCorrect,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey;

    if (disabled) {
      if (isCorrect) {
        backgroundColor = Colors.green.shade100;
        borderColor = Colors.green.shade900;
      } else {
        backgroundColor = Colors.red.shade100;
        borderColor = Colors.red;
      }
    }

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
        ),
          child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green[900]
              ),
          )
              .animate(target: disabled && isCorrect ? 1 : 0)
              .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1))
              .then()
              .scale(begin: const Offset(1.1, 1.1), end: const Offset(1, 1)),
      ),
    );
  }
}
