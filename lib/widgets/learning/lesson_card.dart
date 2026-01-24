import 'package:flutter/material.dart';

import '../../models/learning/lesson_type.dart';
import '../../pages/more/learning/arabic_letters_page.dart';
import '../../pages/more/learning/basic_words_page.dart';
import '../../pages/more/learning/prayer_words_page.dart';

class LessonCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final LessonType type;

  const LessonCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.type,
  });

  void _openLesson(BuildContext context) {
    Widget page;

    switch (type) {
      case LessonType.letters:
        page = const ArabicLettersPage();
        break;
      case LessonType.basicWords:
        page = const BasicWordsPage();
        break;
      case LessonType.prayerWords:
        page = const PrayerWordsPage();
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openLesson(context),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          // color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
            // BoxShadow(
            //   color: color.withOpacity(0.4),
            //   blurRadius: 12,
            //   offset: const Offset(0, 5),
            // ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.green.withOpacity(0.2),
              child: Icon(icon, color: Colors.green[900], size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.green[900],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.green[900],
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
