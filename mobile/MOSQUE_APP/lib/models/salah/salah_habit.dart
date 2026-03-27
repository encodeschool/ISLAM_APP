import 'package:mosque/models/salah/salah_type.dart';

enum SalahStatus {
  notPrayed,
  prayedAlone,
  prayedInJamaah,
  prayedInMosque,
}

class SalahHabit {
  final SalahType salah;
  final DateTime date;
  final SalahStatus status;

  SalahHabit({
    required this.salah,
    required this.date,
    required this.status,
  });

  int get score {
    switch (status) {
      case SalahStatus.prayedAlone:
        return 1;
      case SalahStatus.prayedInJamaah:
        return 2;
      case SalahStatus.prayedInMosque:
        return 3;
      default:
        return 0;
    }
  }
}
