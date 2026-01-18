// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق المسجد';

  @override
  String get settings => 'الإعدادات';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get language => 'اللغة';

  @override
  String get prayerTimes => 'مواقيت الصلاة';

  @override
  String get nextPrayer => 'الصلاة القادمة';

  @override
  String get timeLeft => 'الوقت المتبقي';

  @override
  String get qibla => 'القبلة';

  @override
  String get zikr => 'الذكر';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get custom => 'مخصص';

  @override
  String get manualAdjustment => 'تعديل وقت الصلاة يدويًا';

  @override
  String get comingSoon => 'قريبًا';
}
