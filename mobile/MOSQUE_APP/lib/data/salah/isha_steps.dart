import '../../models/salah/salah_audience.dart';
import '../../models/salah/salah_step.dart';

// Helper to build a standard rakat-1 sequence (intention + 8 more steps)
// and rakat-2 through rakat-N sequences. We inline them for readability.

final List<SalahStep> ishaSteps = [

  // ══════════════════════════════════════════
  // 4 RAKAT SUNNAH (Qabliyya)
  // ══════════════════════════════════════════
  SalahStep(
    type: SalahStepType.info,
    descriptionKey: 'isha_first_sunnah_info',
  ),

  // ── Rakat 1 ──────────────────────────────
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/1_intention.png', 'female_hanafi': 'assets/images/salah/female/1_intention.png'},
    descriptionKey: 'sunnah_first_rakkah_intention', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/2_takbir.png', 'female_hanafi': 'assets/images/salah/female/2_takbir.png'},
    descriptionKey: 'sunnah_first_rakkah_takbir', arabicText: 'الله أكبرُ', audioAssets: {'male_hanafi': 'assets/audio/salah/male/02_Takbir.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/3_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/03_Subhanaka+04_Istiaza.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/3_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'sunnah_first_rakkah_kiraat', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/05_Fatiha+12_Kausar.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/4_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/5_sujud.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/7_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/8_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/9_second_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),

  // ── Rakat 2 ──────────────────────────────
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/10_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Basmala.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/11_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'sunnah_first_rakkah_kiraat_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Fatiha+Ikhlas.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/12_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/13_straightning.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/14_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/15_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/16_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  // Qa'da Ula
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/17_tashahhud.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'prayer_qa_ula_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),

  // ── Rakat 3 ──────────────────────────────
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/10_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Basmala.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/11_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'sunnah_first_rakkah_kiraat_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Fatiha+Ikhlas.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/12_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/13_straightning.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/14_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/15_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/16_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),

  // ── Rakat 4 + Qa'da Akhira ───────────────
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/10_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Basmala.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/11_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'sunnah_first_rakkah_kiraat_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Fatiha+Ikhlas.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/12_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/13_straightning.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/14_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/15_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/16_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/17_tashahhud.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_tashahhud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/13_attahiyat+14_Salavat+15_dua attahiyat.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/18_salam.png', 'female_hanafi': 'assets/images/salah/female/18_salam.png'},
    descriptionKey: 'sunnah_first_rakkah_salam', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/16_salam.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/19_dua.png', 'female_hanafi': 'assets/images/salah/female/19_dua.png'},
    descriptionKey: 'sunnah_first_rakkah_dua', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/17_dua posle namaza.mp3'},
  ),

  // ══════════════════════════════════════════
  // 4 RAKAT FARD
  // ══════════════════════════════════════════
  SalahStep(
    type: SalahStepType.info,
    descriptionKey: 'isha_farz_info',
  ),

  // ── Rakat 1 ──────────────────────────────
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/1_intention.png', 'female_hanafi': 'assets/images/salah/female/1_intention.png'},
    descriptionKey: 'sunnah_first_rakkah_intention', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/2_takbir.png', 'female_hanafi': 'assets/images/salah/female/2_takbir.png'},
    descriptionKey: 'sunnah_first_rakkah_takbir', arabicText: 'الله أكبرُ', audioAssets: {'male_hanafi': 'assets/audio/salah/male/02_Takbir.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/3_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/03_Subhanaka+04_Istiaza.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/3_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'sunnah_first_rakkah_kiraat', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/05_Fatiha+12_Kausar.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/4_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/5_sujud.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/7_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/8_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/9_second_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),

  // ── Rakat 2 ──────────────────────────────
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/10_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Basmala.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/11_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'sunnah_first_rakkah_kiraat_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Fatiha+Ikhlas.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/12_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/13_straightning.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/14_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/15_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/16_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  // Qa'da Ula
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/17_tashahhud.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'prayer_qa_ula_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),

  // ── Rakat 3 (Fatiha only) ────────────────
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/10_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Basmala.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/11_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'farz_kiraat_fatiha_only', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/12_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/13_straightning.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/14_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/15_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/16_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),

  // ── Rakat 4 (Fatiha only) + Qa'da Akhira ─
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/10_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Basmala.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/11_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'farz_kiraat_fatiha_only', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/12_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/13_straightning.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/14_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/15_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/16_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/17_tashahhud.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_tashahhud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/13_attahiyat+14_Salavat+15_dua attahiyat.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/18_salam.png', 'female_hanafi': 'assets/images/salah/female/18_salam.png'},
    descriptionKey: 'sunnah_first_rakkah_salam', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/16_salam.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/19_dua.png', 'female_hanafi': 'assets/images/salah/female/19_dua.png'},
    descriptionKey: 'sunnah_first_rakkah_dua', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/17_dua posle namaza.mp3'},
  ),

  // ══════════════════════════════════════════
  // 2 RAKAT SUNNAH (Ba'diyya)
  // ══════════════════════════════════════════
  SalahStep(
    type: SalahStepType.info,
    descriptionKey: 'isha_second_sunnah_info',
  ),

  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/1_intention.png', 'female_hanafi': 'assets/images/salah/female/1_intention.png'},
    descriptionKey: 'sunnah_first_rakkah_intention', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/2_takbir.png', 'female_hanafi': 'assets/images/salah/female/2_takbir.png'},
    descriptionKey: 'sunnah_first_rakkah_takbir', arabicText: 'الله أكبرُ', audioAssets: {'male_hanafi': 'assets/audio/salah/male/02_Takbir.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/3_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/03_Subhanaka+04_Istiaza.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/3_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'sunnah_first_rakkah_kiraat', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/05_Fatiha+12_Kausar.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/4_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/5_sujud.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/7_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/8_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/9_second_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/10_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Basmala.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/11_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'sunnah_first_rakkah_kiraat_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Fatiha+Ikhlas.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/12_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/13_straightning.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/14_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/15_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/16_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/17_tashahhud.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_tashahhud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/13_attahiyat+14_Salavat+15_dua attahiyat.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/18_salam.png', 'female_hanafi': 'assets/images/salah/female/18_salam.png'},
    descriptionKey: 'sunnah_first_rakkah_salam', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/16_salam.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/19_dua.png', 'female_hanafi': 'assets/images/salah/female/19_dua.png'},
    descriptionKey: 'sunnah_first_rakkah_dua', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/17_dua posle namaza.mp3'},
  ),

  // ══════════════════════════════════════════
  // 3 RAKAT WITR (Wajib in Hanafi)
  // ══════════════════════════════════════════
  SalahStep(
    type: SalahStepType.info,
    descriptionKey: 'isha_witr_info',
  ),

  // ── Rakat 1 ──────────────────────────────
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/1_intention.png', 'female_hanafi': 'assets/images/salah/female/1_intention.png'},
    descriptionKey: 'sunnah_first_rakkah_intention', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/2_takbir.png', 'female_hanafi': 'assets/images/salah/female/2_takbir.png'},
    descriptionKey: 'sunnah_first_rakkah_takbir', arabicText: 'الله أكبرُ', audioAssets: {'male_hanafi': 'assets/audio/salah/male/02_Takbir.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/3_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/03_Subhanaka+04_Istiaza.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/3_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'sunnah_first_rakkah_kiraat', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/05_Fatiha+12_Kausar.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/4_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/5_sujud.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/7_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/8_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/9_second_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),

  // ── Rakat 2 ──────────────────────────────
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/10_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Basmala.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/11_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'sunnah_first_rakkah_kiraat_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Fatiha+Ikhlas.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/12_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/13_straightning.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/14_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/15_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/16_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  // Qa'da Ula (Witr has qa'da ula after rakat 2)
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/17_tashahhud.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'prayer_qa_ula_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),

  // ── Rakat 3 (with Qunut before Ruku) ─────
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/10_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'sunnah_first_rakkah_qiyam_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Basmala.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/11_kiraat.png', 'female_hanafi': 'assets/images/salah/female/3_kiraat.png'},
    descriptionKey: 'sunnah_first_rakkah_kiraat_second_time', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/Fatiha+Ikhlas.mp3'},
  ),
  // Dua al-Qunut (unique to Witr rakat 3)
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/3_qiyam.png', 'female_hanafi': 'assets/images/salah/female/3_qiyam.png'},
    descriptionKey: 'witr_qunut',
    arabicText: 'اللهم إنا نستعينك',
    audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/12_ruku.png', 'female_hanafi': 'assets/images/salah/female/4_ruku.png'},
    descriptionKey: 'sunnah_first_rakkah_rukku', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/07_Dua ruku.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/13_straightning.png', 'female_hanafi': 'assets/images/salah/female/6_straightning.png'},
    descriptionKey: 'sunnah_first_rakkah_sujud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/08_SamiaLlahu+09_Rabbana.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/14_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/15_sitting.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_sitting', arabicText: '', audioAssets: {'male_hanafi': ''},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/16_sajda.png', 'female_hanafi': 'assets/images/salah/female/7_sajda.png'},
    descriptionKey: 'sunnah_first_rakkah_sajda', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/10_Dua sudjud.mp3'},
  ),
  // Qa'da Akhira (Witr)
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/17_tashahhud.png', 'female_hanafi': 'assets/images/salah/female/8_sitting_legs.png'},
    descriptionKey: 'sunnah_first_rakkah_tashahhud', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/13_attahiyat+14_Salavat+15_dua attahiyat.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/18_salam.png', 'female_hanafi': 'assets/images/salah/female/18_salam.png'},
    descriptionKey: 'sunnah_first_rakkah_salam', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/16_salam.mp3'},
  ),
  SalahStep(
    images: {'male_hanafi': 'assets/images/salah/male/19_dua.png', 'female_hanafi': 'assets/images/salah/female/19_dua.png'},
    descriptionKey: 'sunnah_first_rakkah_dua', arabicText: '', audioAssets: {'male_hanafi': 'assets/audio/salah/male/17_dua posle namaza.mp3'},
  ),
];
