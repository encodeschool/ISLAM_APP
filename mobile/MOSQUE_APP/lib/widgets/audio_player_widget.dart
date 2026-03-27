import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioControls extends StatefulWidget {
  final String audioAsset;
  final String arabicMeaning;
  const AudioControls({super.key, required this.audioAsset, required this.arabicMeaning});

  @override
  State<AudioControls> createState() => _AudioControlsState();
}

class _AudioControlsState extends State<AudioControls> {
  late AudioPlayer _player;
  double _speed = 1.0;
  final List<double> _speedOptions = [0.5, 1.0, 1.5, 2.0];

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _player.setAsset(widget.audioAsset);
      await _player.setSpeed(_speed);
    } catch (e) {
      debugPrint("Audio load error: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _cycleSpeed() {
    final currentIndex = _speedOptions.indexOf(_speed);
    final nextIndex = (currentIndex + 1) % _speedOptions.length;
    final newSpeed = _speedOptions[nextIndex];

    setState(() => _speed = newSpeed);
    _player.setSpeed(newSpeed);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Colors.green.shade900;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<SequenceState?>(
          stream: _player.sequenceStateStream,
          builder: (context, snapshot) {
            if (snapshot.data?.currentSource == null) {
              return const SizedBox(
                height: 80,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return StreamBuilder<Duration?>(
              stream: _player.durationStream,
              builder: (context, durationSnap) {
                final duration = durationSnap.data ?? Duration.zero;

                return StreamBuilder<Duration>(
                  stream: _player.positionStream,
                  builder: (context, positionSnap) {
                    final position = positionSnap.data ?? Duration.zero;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        const SizedBox(height: 12),

                        Text(
                          widget.arabicMeaning,
                          style: const TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(4)
                              ),
                              child: Text(
                                _formatDuration(position),
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                                  activeTrackColor: primaryColor,
                                  thumbColor: primaryColor,
                                  trackHeight: 4,
                                ),
                                child: Slider(
                                  value: position.inMilliseconds.toDouble().clamp(0.0, duration.inMilliseconds.toDouble()),
                                  max: duration.inMilliseconds.toDouble() > 0 ? duration.inMilliseconds.toDouble() : 1.0,
                                  onChanged: (value) async {
                                    final newPos = Duration(milliseconds: value.toInt());
                                    await _player.seek(newPos);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Text(
                                _formatDuration(duration),
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Main playback controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // _ControlButton(
                            //   icon: Icons.replay_10,
                            //   onPressed: () async {
                            //     var pos = await _player.position;
                            //     pos -= const Duration(seconds: 10);
                            //     if (pos < Duration.zero) pos = Duration.zero;
                            //     await _player.seek(pos);
                            //   },
                            // ),

                            _ControlButton(
                              icon: Icons.replay,
                              onPressed: () => _player.seek(Duration.zero),
                            ),

                            const SizedBox(width: 16),

                            StreamBuilder<bool>(
                              stream: _player.playingStream,
                              builder: (context, playingSnap) {
                                final isPlaying = playingSnap.data ?? false;
                                return _PlayPauseButton(
                                  isPlaying: isPlaying,
                                  onPressed: () async {
                                    if (isPlaying) {
                                      await _player.pause();
                                    } else {
                                      await _player.play();
                                    }
                                  },
                                );
                              },
                            ),

                            const SizedBox(width: 16),

                            InkWell(
                              onTap: _cycleSpeed,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor, width: 1.5),
                                  borderRadius: BorderRadius.circular(20),
                                  color: primaryColor.withOpacity(0.08),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${_speed.toStringAsFixed(1)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // _ControlButton(
                            //   icon: Icons.forward_10,
                            //   onPressed: () async {
                            //     var pos = await _player.position;
                            //     pos += const Duration(seconds: 10);
                            //     if (pos > duration) pos = duration;
                            //     await _player.seek(pos);
                            //   },
                            // ),
                          ],
                        ),

                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Helper: Play/Pause big button
class _PlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPressed;

  const _PlayPauseButton({
    required this.isPlaying,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: Colors.green.shade100,
        foregroundColor: Colors.green.shade900,
        padding: const EdgeInsets.all(8),
      ),
      iconSize: 52,
      icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
      onPressed: onPressed,
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ControlButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 32),
      color: Colors.green.shade900,
      onPressed: onPressed,
    );
  }
}