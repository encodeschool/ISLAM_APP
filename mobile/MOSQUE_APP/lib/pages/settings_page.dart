import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosque/pages/more/hadith/hadith_detail_page.dart';
import 'package:mosque/pages/more/99_names_page.dart';
import 'package:mosque/pages/more/halal_menu_page.dart';
import 'package:mosque/pages/more/learning_home_page.dart';
import 'package:mosque/pages/more/live_stream_page.dart';
import 'package:mosque/pages/more/motivation_page.dart';
import 'package:mosque/pages/more/qaza_page.dart';
import 'package:mosque/pages/more/habit_tracker_page.dart';
import 'package:mosque/pages/more/shahada_page.dart';
import 'package:mosque/providers/user_setting_provider.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../providers/prayer_provider.dart';
import 'package:adhan/adhan.dart';

import '../widgets/gender_button.dart';
import 'auth/login_page.dart';
import 'profile/profile_page.dart';
import 'more/hadith_list_page.dart';
import 'more/learn_salah_menu_page.dart';
import 'more/salah/salah_lesson_page.dart';
import '../providers/auth_provider.dart';
import 'auth/login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = context.watch<ThemeProvider>();
    final language = context.watch<LanguageProvider>();
    final prayer = context.watch<PrayerProvider>();
    final userSettings = context.watch<UserSettingsProvider>();
    final auth = context.watch<AuthProvider>();

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

            Text(
              t.gender,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: GenderButton(
                    label: t.male,
                    imagePath: 'assets/icons/male.png',     // your male PNG
                    isSelected: userSettings.gender == 'male',
                    onTap: () => userSettings.setGender('male'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GenderButton(
                    label: t.female,
                    imagePath: 'assets/icons/female.png',   // your female PNG
                    isSelected: userSettings.gender == 'female',
                    onTap: () => userSettings.setGender('female'),
                  ),
                )
              ],
            ),

            const Divider(),

            const SizedBox(height: 16),

            Text(
              t.madhhab,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            DropdownButton<String>(
              value: userSettings.madhhab,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'hanafi',   child: Text('Hanafi')),
                DropdownMenuItem(value: 'maliki',   child: Text('Maliki')),
                DropdownMenuItem(value: 'shafi',    child: Text('Shafi‘i')),
                DropdownMenuItem(value: 'hanbali',  child: Text('Hanbali')),
              ],
              onChanged: (value) {
                if (value != null) userSettings.setMadhhab(value);
              },
            ),

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
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          t.settings,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.tune_outlined),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (auth.isLoggedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfilePage(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                );
              }
            },
            icon: Icon(
              auth.isLoggedIn ? Icons.person : Icons.login,
            ),
          )
        ],
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

          _extraButton(context, t.learnArabic, 'assets/icons/arabic.png', LearningHomePage(),t),
          _extraButton(context, t.learnSalah, 'assets/icons/salah.png', LearnSalahMenuPage(),t),
          _extraButton(context, t.habitTracker, 'assets/icons/calendar.png', SalahHabitPage(),t),
          _extraButton(context, t.calculate_qaza, 'assets/icons/calculator.png', QazaPage(),t),
          _extraButton(context, t.names99, 'assets/icons/99Names.png', NinetyNineNames(), t),
          _extraButton(context, t.phrases40, 'assets/icons/hadith.png', HadithListPage(),t),
          // _extraButton(context, t.halal, 'assets/icons/halal.png', HalalThingsMenuPage(),t),
          _extraButton(context, t.makkaLive, 'assets/icons/online.png', LiveStream(),t),
          _extraButton(context, t.shahada, 'assets/icons/shahada.png', ShahadaPage(),t),
        ],
      ),
    );
  }

  Widget _extraButton(BuildContext context, String title, String icon, Widget page, AppLocalizations t) {
    return SettingsCard(
      child: ListTile(
        leading: Image.asset(
          icon,
          width: 35,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.green[900],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => page),
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
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: child,
    );
  }
}
