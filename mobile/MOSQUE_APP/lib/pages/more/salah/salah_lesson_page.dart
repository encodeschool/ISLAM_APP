import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mosque/l10n/app_localizations_extension.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/salah/salah_audience.dart';
import '../../../models/salah/salah_mashab.dart';
import '../../../models/salah/salah_step.dart';
import '../../../providers/user_setting_provider.dart';
import '../../../widgets/audio_player_widget.dart';
import 'package:flutter_html/flutter_html.dart';

class SalahLessonPage extends StatefulWidget {
  final String title;
  final List<SalahStep> steps;

  const SalahLessonPage({
    super.key,
    required this.title,
    required this.steps,
  });

  @override
  State<SalahLessonPage> createState() => _SalahLessonPageState();
}

class _SalahLessonPageState extends State<SalahLessonPage> {
  int currentIndex = 0;
  final PageController _controller = PageController();
  final AudioPlayer _player = AudioPlayer();

  late List<SalahStep> visibleSteps;

  @override
  void initState() {
    super.initState();
    _filterSteps();
  }

  void _filterSteps() {
    final settings = context.read<UserSettingsProvider>();
    final gender = settings.gender;
    final mashhab = settings.madhhab; // string

    final userMashhab = SalahMashhab.values.firstWhere(
          (m) => m.name == mashhab,
      orElse: () => SalahMashhab.hanafi,
    );

    visibleSteps = widget.steps.where((step) {
      // Audience check
      final audienceOk =
          step.audience == SalahAudience.all ||
              (step.audience == SalahAudience.maleOnly && gender == 'male') ||
              (step.audience == SalahAudience.femaleOnly && gender == 'female');

      // Madhhab check
      final mashhabOk =
          step.mashhab == userMashhab;

      return audienceOk && mashhabOk;
    }).toList();
  }


  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  void _playAudio(String asset) async {
    await _player.setAsset(asset);
    _player.play();
  }

  void _next() {
    if (currentIndex < visibleSteps.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _prev() {
    if (currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final step = visibleSteps[currentIndex];

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: visibleSteps.length,
              onPageChanged: (i) => setState(() => currentIndex = i),
              itemBuilder: (context, i) {
                final s = visibleSteps[i];
                if (s.type == SalahStepType.info) {
                  return _InfoStep(s, t);
                }
                return _ContentStep(s, t);
              },
            ),
          ),
          _BottomBar(t),
        ],
      ),
    );
  }

  Widget _InfoStep(SalahStep step, AppLocalizations t) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info, size: 48, color: Colors.green[900]),
            const SizedBox(height: 16),
            Html(
              data: t.translate(step.descriptionKey),
              style: {
                "body": Style(
                  textAlign: TextAlign.center,
                  fontSize: FontSize(16),
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
              },
            ),
            const SizedBox(height: 16),
            Text(
              t.swipeRightToContinue,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Image.asset('assets/icons/swipe.png', width: 50),
          ],
        ),
      ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1),
    );
  }

  Widget _ContentStep(SalahStep step, AppLocalizations t) {
    final settings = context.read<UserSettingsProvider>();

    final image = step.resolveImage(
      gender: settings.gender,
      mashhab: SalahMashhab.values.firstWhere(
            (m) => m.name == settings.madhhab,
      ),
    );

    final audio = step.resolveAudio(
      gender: settings.gender,
      madhhab: SalahMashhab.values.firstWhere(
            (m) => m.name == settings.madhhab,
      )
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (image != null)
            Image.asset(image, height: 220),
          const SizedBox(height: 10),
          Html(
            data: t.translate(step.descriptionKey),
            style: {
              "body": Style(
                textAlign: TextAlign.center,
                fontSize: FontSize(16),
              ),
            },
          ),
          if (audio != null && audio.isNotEmpty)
            AudioControls(
              audioAsset: audio,
              arabicMeaning: step.arabicText ?? '',
            ),
        ],
      ),
    );
  }

  Widget _BottomBar(AppLocalizations t) {
    final step = visibleSteps[currentIndex];

    if (step.type == SalahStepType.info) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          _NavButton(Icons.arrow_back_ios, _prev),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (currentIndex + 1) / visibleSteps.length,
                  color: Colors.green[900],
                  backgroundColor: Colors.green.shade100,
                ),
                const SizedBox(height: 6),
                Text('${currentIndex + 1} / ${visibleSteps.length}'),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _NavButton(Icons.arrow_forward_ios, _next),
        ],
      ),
    );
  }

  Widget _NavButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: Icon(icon, size: 14),
        onPressed: onTap,
      ),
    );
  }
}
