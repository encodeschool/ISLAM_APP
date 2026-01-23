import 'package:flutter/material.dart';
import 'package:mosque/models/hadith.dart';
import '../../data/hadith_40.dart';
// import '.././widgets/islamic_card.dart';
import '../../l10n/app_localizations.dart';
import 'hadith_detail_page.dart';

class HadithListPage extends StatelessWidget {
  const HadithListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    String getLocalizationMeaning(Hadith h) {
      switch (locale) {
        case "ru":
          return h.titleRu ?? h.titleEn;
        case "uz":
          return h.titleUz ?? h.titleEn;
        default:
          return h.titleEn;
      }
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(t.hadith),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: fortyHadith.length,
        itemBuilder: (context, index) {
          final hadith = fortyHadith[index];

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
              title: Text(
                "${t.hadith} ${hadith.id}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                getLocalizationMeaning(hadith)
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        HadithDetailPage(
                            hadith: hadith
                        ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
