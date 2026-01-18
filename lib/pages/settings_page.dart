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

    return Scaffold(
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
        actions: const [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 12),
            child: Icon(Icons.tune_outlined),
          ),
        ],
      ),
      // body: ListView(
      //   padding: const EdgeInsets.all(16),
      //   children: [
      //     Padding(
      //       padding: const EdgeInsetsDirectional.only(bottom: 8),
      //       child: Text(
      //         "Explore",
      //         style: TextStyle(
      //           fontSize: 14,
      //           color: Colors.grey.shade600,
      //         ),
      //       ),
      //     ),
      //
      //     _extraButton(context, "99 Names", Icons.auto_awesome_outlined),
      //     _extraButton(context, "40 Phrases", Icons.format_list_bulleted),
      //     _extraButton(context, "Motivation", Icons.favorite_border),
      //     _extraButton(context, "Makka Live", Icons.live_tv_outlined),
      //     _extraButton(context, "Shahada", Icons.mosque_outlined),
      //   ],
      // ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: Text(t.darkMode),
            value: theme.isDark,
            onChanged: theme.toggleTheme,
          ),

          const Divider(),

          ListTile(
            title: const Text("Language"),
            trailing: DropdownButton<String>(
              value: language.locale.languageCode,
              items: const [
                DropdownMenuItem(value: 'en', child: Text("English")),
                DropdownMenuItem(value: 'ar', child: Text("Arabic")),
                DropdownMenuItem(value: 'ru', child: Text("Russian")),
                DropdownMenuItem(value: 'uz', child: Text("Uzbek")),
              ],
              onChanged: (value) {
                if (value != null) {
                  language.setLanguage(value);
                }
              },
            ),
          ),

          const Divider(),

          const Text(
            "Manual Prayer Time Adjustment (minutes)",
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
              title: Text(p.name.toUpperCase()),
              trailing: SizedBox(
                width: 60,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "0",
                  ),
                  onSubmitted: (value) {
                    final minutes = int.tryParse(value) ?? 0;
                    prayer.setManualOffset(p, minutes);
                  },
                ),
              ),
            ),
          ),

          const Divider(),

          _extraButton(context, "99 Names", Icons.auto_awesome_outlined),
          _extraButton(context, "40 Phrases", Icons.format_list_bulleted),
          _extraButton(context, "Motivation", Icons.favorite_border),
          _extraButton(context, "Makka Live", Icons.live_tv_outlined),
          _extraButton(context, "Shahada", Icons.mosque_outlined),
        ],
      ),
    );
  }

  Widget _extraButton(BuildContext context, String title, IconData icon) {
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
            SnackBar(content: Text("$title coming soon")),
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

