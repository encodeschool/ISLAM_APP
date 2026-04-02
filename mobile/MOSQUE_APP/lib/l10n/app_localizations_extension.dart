import 'app_localizations.dart';

extension AppLocalizationsExtension on AppLocalizations {
  String translate(String key) {
    switch (key) {
      case 'sunnah_first_rakkah_intention':
        return sunnah_first_rakkah_intention;
      case 'sunnah_first_rakkah_takbir':
        return sunnah_first_rakkah_takbir;
      case 'sunnah_first_rakkah_qiyam':
        return sunnah_first_rakkah_qiyam;
      case 'sunnah_first_rakkah_kiraat':
        return sunnah_first_rakkah_kiraat;
      case 'sunnah_first_rakkah_rukku':
        return sunnah_first_rakkah_rukku;
      case 'sunnah_first_rakkah_sajda':
        return sunnah_first_rakkah_sajda;
      case 'sunnah_first_rakkah_sitting':
        return sunnah_first_rakkah_sitting;
      case 'sunnah_first_rakkah_qiyam_second_time':
        return sunnah_first_rakkah_qiyam_second_time;
      case 'sunnah_first_rakkah_kiraat_second_time':
        return sunnah_first_rakkah_kiraat_second_time;
      case 'sunnah_first_rakkah_sujud':
        return sunnah_first_rakkah_sujud;
      case 'sunnah_first_rakkah_tashahhud':
        return sunnah_first_rakkah_tashahhud;
      case 'sunnah_first_rakkah_salam':
        return sunnah_first_rakkah_salam;
      case 'sunnah_first_rakkah_dua':
        return sunnah_first_rakkah_dua;
      case 'fajr_sunnah_info':
        return fajr_sunnah_info;
      case 'fajr_farz_info':
        return fajr_farz_info;
      case 'zuhr_first_sunnah_info':
        return zuhr_first_sunnah_info;
        case 'fajr_female_sunnah_info':
        return fajr_female_sunnah_info;
      case 'prayer_qa_ula_sitting':
        return prayer_qa_ula_sitting;
      case 'farz_kiraat_fatiha_only':
        return farz_kiraat_fatiha_only;
      case 'zuhr_farz_info':
        return zuhr_farz_info;
      case 'zuhr_second_sunnah_info':
        return zuhr_second_sunnah_info;
      case 'asr_sunnah_info':
        return asr_sunnah_info;
      case 'asr_farz_info':
        return asr_farz_info;
      case 'maghrib_farz_info':
        return maghrib_farz_info;
      case 'maghrib_sunnah_info':
        return maghrib_sunnah_info;
      case 'isha_first_sunnah_info':
        return isha_first_sunnah_info;
      case 'isha_farz_info':
        return isha_farz_info;
      case 'isha_second_sunnah_info':
        return isha_second_sunnah_info;
      case 'isha_witr_info':
        return isha_witr_info;
      case 'witr_qunut':
        return witr_qunut;
      default:
        return key;
    }
  }
}
