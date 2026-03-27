import 'package:adhan/adhan.dart';
import '../../l10n/app_localizations.dart';

extension PrayerLocalization on Prayer {
  String localizedName(AppLocalizations t) {
    switch (this) {
      case Prayer.fajr:
        return t.fajr;
      case Prayer.dhuhr:
        return t.dhuhr;
      case Prayer.asr:
        return t.asr;
      case Prayer.maghrib:
        return t.maghrib;
      case Prayer.isha:
        return t.isha;
      default:
        return '';
    }
  }
}
