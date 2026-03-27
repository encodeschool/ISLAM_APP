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
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.black, size: 28),
          title: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 4),
              // Text(
              //   subtitle,
              //   style: TextStyle(
              //     color: Colors.black,
              //   ),
              // ),
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
