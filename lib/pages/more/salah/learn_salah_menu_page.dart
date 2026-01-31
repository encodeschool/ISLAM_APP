import 'package:flutter/material.dart';
import 'package:mosque/models/salah/salah_step.dart';
import '../../../data/salah/fajr_steps.dart';
import '../../../data/salah/wudu_steps.dart';
import 'salah_lesson_page.dart';

class LearnSalahMenuPage extends StatelessWidget {
  const LearnSalahMenuPage({super.key});

  void _openLesson(
      BuildContext context, {
        required String title,
        required List<SalahStep> steps,
      }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SalahLessonPage(
          title: title,
          steps: steps,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Salah'),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _SalahTile(
            icon: 'assets/icons/ablution.png',
            title: 'Learn Ablution (Wudu)',
            subtitle: 'Step-by-step purification',
            onTap: () {
              _openLesson(
                context,
                title: 'Ablution (Wudu)',
                steps: wuduSteps,
              );
            },
          ),

          _SalahTile(
            icon: 'assets/icons/fajr.png',
            title: 'Fajr Prayer',
            subtitle: '2 rakah obligatory prayer',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SalahLessonPage(
                    title: 'Fajr Salah',
                    steps: fajrSteps,
                  ),
                ),
              );
            },
          ),

          _SalahTile(
            icon: 'assets/icons/dhuhr.png',
            title: 'Zuhr Prayer',
            subtitle: '4 rakah obligatory prayer',
            onTap: () {},
          ),

          _SalahTile(
            icon: 'assets/icons/asr.png',
            title: 'Asr Prayer',
            subtitle: '4 rakah obligatory prayer',
            onTap: () {},
          ),

          _SalahTile(
            icon: 'assets/icons/maghrib.png',
            title: 'Maghrib Prayer',
            subtitle: '4 rakah obligatory prayer',
            onTap: () {},
          ),

          _SalahTile(
            icon: 'assets/icons/isha.png',
            title: 'Isha Prayer',
            subtitle: '4 rakah obligatory prayer',
            onTap: () {},
          ),

          // Add others later
        ],
      ),
    );
  }
}

class _SalahTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SalahTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        leading: Image.asset(icon),
        title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}