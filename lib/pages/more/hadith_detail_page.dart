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
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/header_bg.png"),
                fit: BoxFit.cover
              ),
              color: Colors.black.withOpacity(0.25)
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            scrolledUnderElevation: 0,
            title: Text(
                "${t.hadith} ${hadith.id}",
                style: TextStyle(
                  color: Colors.white
                ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              SizedBox(
                height: 150,
                child: Center(
                  child: Text(
                    hadith.arabic,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 32,
                      color: Colors.white
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 16,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: Material(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                          left: 15,
                          right: 15
                        ),
                        child: Text(
                          getLocalizedMeaning(hadith),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
