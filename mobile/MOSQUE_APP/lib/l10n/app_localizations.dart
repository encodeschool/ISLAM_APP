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

  /// No description provided for @male.
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

  /// No description provided for @swipeRightToContinue.
  ///
  /// In en, this message translates to:
  /// **'Swipe to Right to continue'**
  String get swipeRightToContinue;

  /// No description provided for @sunnah_first_rakkah_intention.
  ///
  /// In en, this message translates to:
  /// **'The intention can be expressed mentally as follows:<br><br><b>I intend to perform (the type of prayer).</b>'**
  String get sunnah_first_rakkah_intention;

  /// No description provided for @sunnah_first_rakkah_takbir.
  ///
  /// In en, this message translates to:
  /// **'Facing the direction of the Qibla, the Muslim raises both hands to the level of the ears and pronounces the first takbir:<br><br><b>Allahu Akbar!</b>'**
  String get sunnah_first_rakkah_takbir;

  /// No description provided for @sunnah_first_rakkah_qiyam.
  ///
  /// In en, this message translates to:
  /// **'In this position, first the opening supplication (dua Sana, <b>Subhanaka</b>) is recited. Then the formula seeking protection from Shaytan is pronounced, followed by the basmala.<br><br><b>Subhanakallahumma wa bihamdik,</b><br>wa tabarakasmuk,<br>wa ta‘ala jadduk,<br>wa la ilaha ghayruk.<br><br><b>A‘udhu billahi minash-shaytanir-rajim,</b><br><b>Bismillahir-Rahmanir-Rahim.</b>'**
  String get sunnah_first_rakkah_qiyam;

  /// No description provided for @sunnah_first_rakkah_kiraat.
  ///
  /// In en, this message translates to:
  /// **'Then the worshipper recites <b>Surah Al-Fatiha</b>. After completing Surah Al-Fatiha, the worshipper says <b>Amin</b> (quietly).<br><br><b>Surah Al-Fatiha:</b><br>Al-hamdu lillahi rabbil-‘alamin<br>Ar-Rahmanir-Rahim<br>Maliki yawmid-din<br>Ihdinas-siratal-mustaqim<br>Siratal-ladhina an‘amta ‘alayhim<br>Ghayril-maghdubi ‘alayhim wa lad-dallin<br><br><b>Surah Al-Kawthar:</b><br>Inna a‘taynakal-kawthar<br>Fasalli li rabbika wanhar<br>Inna shani’aka huwal-abtar'**
  String get sunnah_first_rakkah_kiraat;

  /// No description provided for @sunnah_first_rakkah_rukku.
  ///
  /// In en, this message translates to:
  /// **'After finishing the recitation of the additional surah, the worshipper says the takbir:<br><br><b>Allahu Akbar</b><br><br>and performs the bowing (<b>ruku‘</b>).<br><br>While in ruku‘, it is recommended to quietly say three times:<br><br><b>Subhana rabbiyal-‘azim.</b>'**
  String get sunnah_first_rakkah_rukku;

  /// No description provided for @sunnah_first_rakkah_sajda.
  ///
  /// In en, this message translates to:
  /// **'The worshipper says the takbir:<br><br><b>Allahu Akbar</b><br><br>and goes down into prostration, first onto the knees, then placing the hands, then touching the floor with the tip of the nose, and then the forehead.<br><br>In this position, it is recommended to quietly say three times:<br><br><b>Subhana rabbiyal-a‘la.</b>'**
  String get sunnah_first_rakkah_sajda;

  /// No description provided for @sunnah_first_rakkah_sitting.
  ///
  /// In en, this message translates to:
  /// **'After the prostration, the worshipper sits while saying:<br><br><b>Allahu Akbar</b><br><br>and remains in this position for a short while.'**
  String get sunnah_first_rakkah_sitting;

  /// No description provided for @sunnah_first_rakkah_qiyam_second_time.
  ///
  /// In en, this message translates to:
  /// **'Returning to the standing position (<b>qiyam</b>), the following is recited:<br><br><b>Bismillahir-Rahmanir-Rahim.</b>'**
  String get sunnah_first_rakkah_qiyam_second_time;

  /// No description provided for @sunnah_first_rakkah_kiraat_second_time.
  ///
  /// In en, this message translates to:
  /// **'After this, <b>Surah Al-Fatiha</b> must be recited, followed by any other surah or verses from the Qur’an.<br><br><b>Surah Al-Fatiha:</b><br>Al-hamdu lillahi rabbil-‘alamin<br>Ar-Rahmanir-Rahim<br>Maliki yawmid-din<br>Iyyaka na‘budu wa iyyaka nasta‘in<br>Ihdinas-siratal-mustaqim<br>Siratal-ladhina an‘amta ‘alayhim<br>Ghayril-maghdubi ‘alayhim wa lad-dallin<br><br><i>(Amin is said quietly)</i><br><br><b>Surah Al-Ikhlas:</b><br>Qul huwallahu ahad<br>Allahu-s-samad<br>Lam yalid wa lam yulad<br>Wa lam yakun lahu kufuwan ahad'**
  String get sunnah_first_rakkah_kiraat_second_time;

  /// No description provided for @sunnah_first_rakkah_sujud.
  ///
  /// In en, this message translates to:
  /// **'While straightening up from the bowing position, the worshipper says:<br><br><b>Sami‘allahu liman hamidah</b><br><br>until fully standing upright.<br><br>After standing upright, he says:<br><br><b>Rabbana wa lakal-hamd.</b>'**
  String get sunnah_first_rakkah_sujud;

  /// No description provided for @sunnah_first_rakkah_tashahhud.
  ///
  /// In en, this message translates to:
  /// **'After performing the second prostration, the worshipper sits as between the two prostrations and recites the <b>tashahhud</b>. After the tashahhud, <b>salawat</b> is recited, followed by a supplication (<b>dua</b>) in Arabic without raising the hands.<br><br>During the words <b>“Ashhadu alla ilaha”</b>, the worshipper raises the index finger of the right hand towards the Qibla (not upwards), and lowers it at <b>“illallah”</b>.<br><br><b>At-tahiyyatu lillahi was-salawatu wat-tayyibat...</b><br><br><b>Rabbana atina fid-dunya hasanatan,</b><br>wa fil-akhirati hasanatan,<br>wa qina ‘adhaban-nar'**
  String get sunnah_first_rakkah_tashahhud;

  /// No description provided for @sunnah_first_rakkah_salam.
  ///
  /// In en, this message translates to:
  /// **'After reciting the salawat and supplication, the worshipper turns the head to the right and says the salam, then turns the head to the left and repeats the salam, looking towards the edge of the shoulder.<br><br><b>Assalamu ‘alaykum wa rahmatullah!</b>'**
  String get sunnah_first_rakkah_salam;

  /// No description provided for @sunnah_first_rakkah_dua.
  ///
  /// In en, this message translates to:
  /// **'After completing the prayer, it is recommended to raise both hands to chest level with a small space between them, palms facing the face, and recite the <b>dua of istighfar</b>.<br><br><b>Astaghfirullah! Astaghfirullah! Astaghfirullah!</b><br><br><b>Allahumma anta-s-salam wa minka-s-salam tabarakta</b><br><b>ya dhal-jalali wal-ikram</b>'**
  String get sunnah_first_rakkah_dua;

  /// No description provided for @fajr_sunnah_info.
  ///
  /// In en, this message translates to:
  /// **'First, pray the 2 rakah Sunnah of Fajr.'**
  String get fajr_sunnah_info;

  /// No description provided for @fajr_farz_info.
  ///
  /// In en, this message translates to:
  /// **'Now perform 2 rakats of fard Fajr.'**
  String get fajr_farz_info;

  /// No description provided for @zuhr_first_sunnah_info.
  ///
  /// In en, this message translates to:
  /// **'Unlike the fard prayers, during Sunnah prayers, the additional surah is recited in all rakaats, including the third and fourth. <br><br> <b>During Zuhr prayers, we recite four Sunnah prayers with one salam, then four fard prayers, then two Sunnah prayers.</b>'**
  String get zuhr_first_sunnah_info;

  /// No description provided for @fajr_fard_info.
  ///
  /// In en, this message translates to:
  /// **'Now pray the 2 rakah obligatory Fajr prayer.'**
  String get fajr_fard_info;

  /// No description provided for @niyyah_fajr_fard.
  ///
  /// In en, this message translates to:
  /// **'Make intention for Fajr prayer.'**
  String get niyyah_fajr_fard;

  /// No description provided for @learnWudu.
  ///
  /// In en, this message translates to:
  /// **'Learn Ablution (Wudu)'**
  String get learnWudu;

  /// No description provided for @wuduSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Step-by-step purification'**
  String get wuduSubtitle;

  /// No description provided for @wuduTitle.
  ///
  /// In en, this message translates to:
  /// **'Ablution (Wudu)'**
  String get wuduTitle;

  /// No description provided for @fajrPrayer.
  ///
  /// In en, this message translates to:
  /// **'Fajr Prayer'**
  String get fajrPrayer;

  /// No description provided for @fajrSubtitle.
  ///
  /// In en, this message translates to:
  /// **'2 rakah obligatory prayer'**
  String get fajrSubtitle;

  /// No description provided for @fajrTitle.
  ///
  /// In en, this message translates to:
  /// **'Fajr Salah'**
  String get fajrTitle;

  /// No description provided for @dhuhrPrayer.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr Prayer'**
  String get dhuhrPrayer;

  /// No description provided for @dhuhrSubtitle.
  ///
  /// In en, this message translates to:
  /// **'4 rakah obligatory prayer'**
  String get dhuhrSubtitle;

  /// No description provided for @asrPrayer.
  ///
  /// In en, this message translates to:
  /// **'Asr Prayer'**
  String get asrPrayer;

  /// No description provided for @asrSubtitle.
  ///
  /// In en, this message translates to:
  /// **'4 rakah obligatory prayer'**
  String get asrSubtitle;

  /// No description provided for @maghribPrayer.
  ///
  /// In en, this message translates to:
  /// **'Maghrib Prayer'**
  String get maghribPrayer;

  /// No description provided for @maghribSubtitle.
  ///
  /// In en, this message translates to:
  /// **'3 rakah obligatory prayer'**
  String get maghribSubtitle;

  /// No description provided for @ishaPrayer.
  ///
  /// In en, this message translates to:
  /// **'Isha Prayer'**
  String get ishaPrayer;

  /// No description provided for @ishaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'4 rakah obligatory prayer'**
  String get ishaSubtitle;

  /// No description provided for @halal.
  ///
  /// In en, this message translates to:
  /// **'Halal things'**
  String get halal;

  /// No description provided for @habitTracker.
  ///
  /// In en, this message translates to:
  /// **'Habit Tracker'**
  String get habitTracker;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @madhhab.
  ///
  /// In en, this message translates to:
  /// **'Madhhab'**
  String get madhhab;

  /// No description provided for @fajr_female_sunnah_info.
  ///
  /// In en, this message translates to:
  /// **'This is info for Females'**
  String get fajr_female_sunnah_info;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;
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
