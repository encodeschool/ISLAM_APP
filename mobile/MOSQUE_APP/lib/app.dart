import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mosque/pages/home_page.dart';
import 'package:mosque/pages/splash_page.dart';
import 'package:mosque/providers/counter_provider.dart';
import 'package:mosque/providers/language_provider.dart';
import 'package:mosque/providers/prayer_provider.dart';
import 'package:mosque/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';

class MosqueApp extends StatelessWidget {
  const MosqueApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mosque App',

      locale: context.watch<LanguageProvider>().locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,

      home: const SplashPage(),
    );
  }
}