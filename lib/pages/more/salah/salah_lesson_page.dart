import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../models/salah/salah_step.dart';
import '../../../widgets/audio_player_widget.dart';

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
    if (currentIndex < widget.steps.length - 1) {
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
    final step = widget.steps[currentIndex];

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
              itemCount: widget.steps.length,
              onPageChanged: (i) => setState(() => currentIndex = i),
              itemBuilder: (context, i) {
                final s = widget.steps[i];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // ← often looks better
                    children: [
                      Image.asset(s.image, height: 220),
                      const SizedBox(height: 10),
                      Text(
                        s.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      AudioControls(
                          audioAsset: s.audioAsset,
                          arabicMeaning: s.arabicText
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          _BottomBar(),
        ],
      ),
    );
  }

  Widget _BottomBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(50)
            ),
            child: IconButton(
              icon: const Icon(
                  size: 14,
                  Icons.arrow_back_ios
              ),
              onPressed: _prev,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (currentIndex + 1) / widget.steps.length,
                  color: Colors.green[900],
                  backgroundColor: Colors.green.shade100,
                ),
                const SizedBox(height: 6),
                Text('${currentIndex + 1} / ${widget.steps.length}'),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(50)
            ),
            child: IconButton(
              icon: const Icon(
                  size: 14,
                  Icons.arrow_forward_ios
              ),
              onPressed: _next,
            ),
          ),
        ],
      ),
    );
  }
}
