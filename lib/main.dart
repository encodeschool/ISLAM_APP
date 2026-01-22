import 'package:flutter/material.dart';
import 'package:mosque/providers/counter_provider.dart';
import 'package:mosque/providers/daily_card_provider.dart';
import 'package:mosque/providers/language_provider.dart';
import 'package:mosque/providers/prayer_provider.dart';
import 'package:mosque/providers/qaza_provider.dart';
import 'package:mosque/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/notification/notification_service.dart';
import 'core/storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  // await NotificationService.init();
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => PrayerProvider()),
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => DailyCardProvider()),
        ChangeNotifierProvider(create: (context) => QazaProvider()),
      ],
      child: const MosqueApp(),
    );
  }
}