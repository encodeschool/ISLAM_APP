import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../core/network/connectivity_service.dart';
import '../../l10n/app_localizations.dart';

class LiveStream extends StatefulWidget {
  const LiveStream({super.key});

  @override
  State<LiveStream> createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {
  late YoutubePlayerController _controller;
  bool _isOnline = false;
  bool _isLoading = true;
  String? _error;

  static const String _videoId = 'PbnhNdaeQFI'; // replace if expired

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _isOnline = await ConnectivityService.isOnline();

    if (!_isOnline) {
      setState(() => _isLoading = false);
      return;
    }

    _controller = YoutubePlayerController.fromVideoId(
      videoId: _videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: false,
        enableCaption: true,
      ),
    );

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
          title: Text(t.makkaLive ?? 'Makkah Live'),
          scrolledUnderElevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : !_isOnline
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              Text(t.noInternet ?? 'No Internet', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: _init,
                child: Text(t.retry ?? 'Retry'),
              ),
            ],
          ),
        ),
      )
          : YoutubePlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
      ),
    );
  }
}