import 'package:mosque/models/salah/salah_audience.dart';
import 'package:mosque/models/salah/salah_mashab.dart';

enum SalahStepType {
  info,
  action,
}

class SalahStep {
  final SalahStepType type;
  final Map<String, String>? images;
  final String descriptionKey;
  final String? arabicText;
  final Map<String, String>? audioAssets;
  final SalahAudience audience;
  final SalahMashhab mashhab;

  SalahStep({
    this.type = SalahStepType.action,
    this.images,
    required this.descriptionKey,
    this.arabicText,
    this.audioAssets,
    this.audience = SalahAudience.all,
    this.mashhab = SalahMashhab.hanafi
  });

  String? resolveImage({
    required String gender,
    required SalahMashhab mashhab,
  }) {
    if (images == null) return null;

    // priority: gender + mashhab → gender → default
    return images!['${gender}_${mashhab.name}'] ??
        images![gender] ??
        images!['default'];
  }

  String? resolveAudio({required String gender,required  SalahMashhab madhhab}) {
    final key = '${gender}_${madhhab.name}';

    if (audioAssets == null) return null;

    return audioAssets![key] ??
        audioAssets![gender] ??
        audioAssets!['default'];
  }
}
