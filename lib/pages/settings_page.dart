import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../providers/prayer_provider.dart';
import 'package:adhan/adhan.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = context.watch<ThemeProvider>();
    final language = context.watch<LanguageProvider>();
    final prayer = context.watch<PrayerProvider>();

    String getPrayerName(Prayer prayer, AppLocalizations t) {
      switch (prayer) {
        case Prayer.fajr:
          return t.prayerFajr;
        case Prayer.dhuhr:
          return t.prayerDhuhr;
        case Prayer.asr:
          return t.prayerAsr;
        case Prayer.maghrib:
          return t.prayerMaghrib;
        case Prayer.isha:
          return t.prayerIsha;
        default:
          return prayer.name;
      }
    }

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: Text(t.darkMode),
              value: theme.isDark,
              onChanged: theme.toggleTheme,
            ),
            const Divider(),

            ListTile(
              title: Text(t.language),
              trailing: DropdownButton<String>(
                value: language.locale.languageCode,
                items: [
                  DropdownMenuItem(value: 'en', child: Text(t.langEnglish)),
                  DropdownMenuItem(value: 'ar', child: Text(t.langArabic)),
                  DropdownMenuItem(value: 'ru', child: Text(t.langRussian)),
                  DropdownMenuItem(value: 'uz', child: Text(t.langUzbek)),
                ],
                onChanged: (value) {
                  if (value != null) {
                    language.setLanguage(value);
                  }
                },
              ),
            ),
            const Divider(),

            // Manual Prayer Time Adjustments
            Text(
              t.manualPrayerAdjustment,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ...[
              Prayer.fajr,
              Prayer.dhuhr,
              Prayer.asr,
              Prayer.maghrib,
              Prayer.isha
            ].map(
                  (p) => ListTile(
                title: Text(getPrayerName(p, t).toUpperCase()),
                trailing: SizedBox(
                  width: 60,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "0"),
                    onSubmitted: (value) {
                      final minutes = int.tryParse(value) ?? 0;
                      prayer.setManualOffset(p, minutes);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          t.settings,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        // open drawer button
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.tune_outlined),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 8),
            child: Text(
              t.explore,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),

          _extraButton(context, t.names99, Icons.auto_awesome_outlined,t),
          _extraButton(context, t.phrases40, Icons.format_list_bulleted,t),
          _extraButton(context, t.motivation, Icons.favorite_border,t),
          _extraButton(context, t.makkaLive, Icons.live_tv_outlined,t),
          _extraButton(context, t.shahada, Icons.mosque_outlined,t),
        ],
      ),
    );
  }

  Widget _extraButton(BuildContext context, String title, IconData icon, AppLocalizations t) {
    return SettingsCard(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${t.comingSoon}")),
          );
        },
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final Widget child;

  const SettingsCard({super.key, required this.child});

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
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
          ),
        ],
      ),
      child: child,
    );
  }
}
