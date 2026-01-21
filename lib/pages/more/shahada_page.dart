import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ShahadaPage extends StatelessWidget {
  const ShahadaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.shahadaTitle),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              t.shahadaArabic,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 30,
                height: 1.8,
                color: Colors.green[900],
              ),
            ),

            const SizedBox(height: 32),

            Text(
                "Ashhadu an lā ilāha illā-llāh, wa ashhadu anna Muḥammadan rasūlu-llāh",
                style: TextStyle(
                  color: Colors.grey
                ),
                textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            Text(
              t.shahadaTranslation,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
