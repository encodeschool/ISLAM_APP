import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('ru'),
    Locale('uz')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Mosque App'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @prayerTimes.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimes;

  /// No description provided for @nextPrayer.
  ///
  /// In en, this message translates to:
  /// **'Next Prayer'**
  String get nextPrayer;

  /// No description provided for @timeLeft.
  ///
  /// In en, this message translates to:
  /// **'Time left'**
  String get timeLeft;

  /// No description provided for @qibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get qibla;

  /// No description provided for @zikr.
  ///
  /// In en, this message translates to:
  /// **'Zikr'**
  String get zikr;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @manualAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Manual Prayer Time Adjustment'**
  String get manualAdjustment;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'{title} coming soon'**
  String comingSoon(Object title);

  /// No description provided for @navPrayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get navPrayer;

  /// No description provided for @navQibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get navQibla;

  /// No description provided for @navZikr.
  ///
  /// In en, this message translates to:
  /// **'Zikr'**
  String get navZikr;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @tap.
  ///
  /// In en, this message translates to:
  /// **'TAP'**
  String get tap;

  /// No description provided for @setCustomZikr.
  ///
  /// In en, this message translates to:
  /// **'Set Custom Zikr'**
  String get setCustomZikr;

  /// No description provided for @enterNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter number'**
  String get enterNumber;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @prayerFajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get prayerFajr;

  /// No description provided for @prayerDhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get prayerDhuhr;

  /// No description provided for @prayerAsr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get prayerAsr;

  /// No description provided for @prayerMaghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get prayerMaghrib;

  /// No description provided for @prayerIsha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get prayerIsha;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @locating.
  ///
  /// In en, this message translates to:
  /// **'Locating…'**
  String get locating;

  /// No description provided for @locationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get locationDenied;

  /// No description provided for @unknownLocation.
  ///
  /// In en, this message translates to:
  /// **'Unknown location'**
  String get unknownLocation;

  /// No description provided for @manualPrayerAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Manual Prayer Time Adjustment (minutes)'**
  String get manualPrayerAdjustment;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @names99.
  ///
  /// In en, this message translates to:
  /// **'99 Names'**
  String get names99;

  /// No description provided for @phrases40.
  ///
  /// In en, this message translates to:
  /// **'Hadith'**
  String get phrases40;

  /// No description provided for @motivation.
  ///
  /// In en, this message translates to:
  /// **'Motivation'**
  String get motivation;

  /// No description provided for @makkaLive.
  ///
  /// In en, this message translates to:
  /// **'Makkah Live'**
  String get makkaLive;

  /// No description provided for @shahada.
  ///
  /// In en, this message translates to:
  /// **'Shahada'**
  String get shahada;

  /// No description provided for @langEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langEnglish;

  /// No description provided for @langArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get langArabic;

  /// No description provided for @langRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get langRussian;

  /// No description provided for @langUzbek.
  ///
  /// In en, this message translates to:
  /// **'Uzbek'**
  String get langUzbek;

  /// No description provided for @namesOfAllah.
  ///
  /// In en, this message translates to:
  /// **'99 Names of Allah'**
  String get namesOfAllah;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @dailyNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Name to Learn'**
  String get dailyNameTitle;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternet;

  /// No description provided for @checkConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get checkConnection;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @foundationOfIslam.
  ///
  /// In en, this message translates to:
  /// **'This is the foundation of Islam'**
  String get foundationOfIslam;

  /// No description provided for @shahadaTitle.
  ///
  /// In en, this message translates to:
  /// **'Shahada'**
  String get shahadaTitle;

  /// No description provided for @shahadaArabic.
  ///
  /// In en, this message translates to:
  /// **'أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا ٱللَّٰهُ\nوَأَشْهَدُ أَنَّ مُحَمَّدًا رَسُولُ ٱللَّٰهِ'**
  String get shahadaArabic;

  /// No description provided for @shahadaTranslation.
  ///
  /// In en, this message translates to:
  /// **'I bear witness that there is no god but Allah, and I bear witness that Muhammad is the Messenger of Allah.'**
  String get shahadaTranslation;

  /// No description provided for @hadith.
  ///
  /// In en, this message translates to:
  /// **'Hadith'**
  String get hadith;

  /// No description provided for @qaza_prayers.
  ///
  /// In en, this message translates to:
  /// **'Missed (Qaza) Prayers'**
  String get qaza_prayers;

  /// No description provided for @start_date.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get start_date;

  /// No description provided for @end_date.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get end_date;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @calculate_qaza.
  ///
  /// In en, this message translates to:
  /// **'Calculate Qaza'**
  String get calculate_qaza;

  /// No description provided for @total_remaining.
  ///
  /// In en, this message translates to:
  /// **'Total Remaining'**
  String get total_remaining;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @mark_done.
  ///
  /// In en, this message translates to:
  /// **'Mark as Completed'**
  String get mark_done;

  /// No description provided for @select_start_and_end_dates.
  ///
  /// In en, this message translates to:
  /// **'Select Start and End Dates'**
  String get select_start_and_end_dates;

  /// No description provided for @learnArabic.
  ///
  /// In en, this message translates to:
  /// **'Learn Arabic'**
  String get learnArabic;

  /// No description provided for @arabicLetter.
  ///
  /// In en, this message translates to:
  /// **'Arabic Letters'**
  String get arabicLetter;

  /// No description provided for @basicWords.
  ///
  /// In en, this message translates to:
  /// **'Basic Words'**
  String get basicWords;

  /// No description provided for @everyDayArabic.
  ///
  /// In en, this message translates to:
  /// **'Everyday Arabic'**
  String get everyDayArabic;

  /// No description provided for @prayerWords.
  ///
  /// In en, this message translates to:
  /// **'Prayer Words'**
  String get prayerWords;

  /// No description provided for @islamicWords.
  ///
  /// In en, this message translates to:
  /// **'Islamic vocabulary'**
  String get islamicWords;

  /// No description provided for @typeTheAnswer.
  ///
  /// In en, this message translates to:
  /// **'Type the answer'**
  String get typeTheAnswer;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect! Try again.'**
  String get incorrect;

  /// No description provided for @match.
  ///
  /// In en, this message translates to:
  /// **'Match Arabic → English'**
  String get match;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct! 🎉'**
  String get correct;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Lv'**
  String get level;

  /// No description provided for @learnSalah.
  ///
  /// In en, this message translates to:
  /// **'Learn salah'**
  String get learnSalah;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
    case 'uz': return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
