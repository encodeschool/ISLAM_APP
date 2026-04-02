import 'package:flutter/material.dart';
import 'package:mosque/data/salah/asr_steps.dart';
import 'package:mosque/data/salah/isha_steps.dart';
import 'package:mosque/data/salah/maghrib_steps.dart';
import 'package:mosque/data/salah/zuhr_steps.dart';
import 'package:mosque/models/salah/salah_step.dart';
import '../../data/salah/fajr_steps.dart';
import '../../data/salah/wudu_steps.dart';
import '../../l10n/app_localizations.dart';
import 'salah/salah_lesson_page.dart';

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
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.learnSalah),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SalahTile(
            icon: 'assets/icons/ablution.png',
            title: t.learnWudu,
            subtitle: t.wuduSubtitle,
            onTap: () => _openLesson(
              context,
              title: t.wuduTitle,
              steps: wuduSteps,
            ),
          ),
          _SalahTile(
            icon: 'assets/icons/fajr.png',
            title: t.fajrPrayer,
            subtitle: t.fajrSubtitle,
            onTap: () => _openLesson(
              context,
              title: t.fajrTitle,
              steps: fajrSteps,
            ),
          ),
          _SalahTile(
            icon: 'assets/icons/dhuhr.png',
            title: t.dhuhrPrayer,
            subtitle: t.dhuhrSubtitle,
            onTap: () => _openLesson(
              context,
              title: t.dhuhrTitle,
              steps: zuhrSteps,
            ),
          ),
          _SalahTile(
            icon: 'assets/icons/asr.png',
            title: t.asrPrayer,
            subtitle: t.asrSubtitle,
            onTap: () => _openLesson(
              context,
              title: t.asrTitle,
              steps: asrSteps,
            ),
          ),
          _SalahTile(
            icon: 'assets/icons/maghrib.png',
            title: t.maghribPrayer,
            subtitle: t.maghribSubtitle,
            onTap: () => _openLesson(
              context,
              title: t.maghribTitle,
              steps: maghribSteps,
            ),
          ),
          _SalahTile(
            icon: 'assets/icons/isha.png',
            title: t.ishaPrayer,
            subtitle: t.ishaSubtitle,
            onTap: () => _openLesson(
              context,
              title: t.ishaTitle,
              steps: ishaSteps,
            ),
          ),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Image.asset(icon, width: 40, height: 40),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
