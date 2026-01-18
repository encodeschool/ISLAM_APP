import 'package:flutter/material.dart';
import 'package:mosque/core/localization/prayer_localization.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/prayer_provider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    return "${h.toString().padLeft(2, '0')}:"
        "${m.toString().padLeft(2, '0')}:"
        "${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final prayer = context.watch<PrayerProvider>();
    Size size = MediaQuery.of(context).size;
    final t = AppLocalizations.of(context)!;

    String locationText;
    if (prayer.isLocating) {
      locationText = t.locating;
    } else if (prayer.locationPermissionDenied) {
      locationText = t.locationDenied;
    } else {
      locationText = prayer.locationName ?? t.unknownLocation;
    }

    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            locationText,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 8),
          if (prayer.nextPrayer != null) ...[
            Text(
              prayer.nextPrayer!.localizedName(t),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
                fontSize: 40,
                fontWeight: FontWeight.w900
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            "-${_formatDuration(prayer.timeLeft)}",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
