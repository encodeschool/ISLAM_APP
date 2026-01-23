import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/hadith.dart';

class HadithDetailPage extends StatelessWidget {
  final Hadith hadith;

  const HadithDetailPage({super.key, required this.hadith});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    String getLocalizedMeaning(Hadith h) {
      switch (locale) {
        case "ru":
          return h.russian ?? h.english;
        case "uz":
          return h.uzbek ?? h.english;
        default:
          return h.english;
      }
    }
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text("Hadith ${hadith.id}"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Arabic
            Text(
              hadith.arabic,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Amiri',
                fontSize: 22,
                height: 1.8,
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // English
            Text(
              getLocalizedMeaning(hadith),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
