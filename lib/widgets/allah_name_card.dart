import 'package:flutter/material.dart';
import '../core/audio_service.dart';
import '../models/allah_name.dart';

class AllahNameCard extends StatelessWidget {
  final AllahName name;
  final VoidCallback onTap;

  const AllahNameCard({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: Color.fromRGBO(0, 100, 0, 0.5),
              width: 2
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          children: [
            // 📄 Main content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.arabic,
                  style: const TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  name.transliteration,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name.meaning,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),

            // 🔊 Audio button (top-right)
            Positioned(
              top: -15,
              right: -15,
              child: IconButton(
                icon: const Icon(Icons.volume_up_outlined),
                onPressed: () {
                  AudioService.play(name.audioAsset);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
