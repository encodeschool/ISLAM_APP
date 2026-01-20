import 'package:flutter/material.dart';

import '../core/audio_service.dart';
import '../core/storage/local_storage.dart';

class CounterProvider extends ChangeNotifier {
  int count = LocalStorage.zikrCount;
  int limit = LocalStorage.zikrLimit;
  String? currentZikrName;

  void startZikr(String name) {
    currentZikrName = name;
    reset();
  }

  void incrementWithAudio(String audio) {
    increment();
    AudioService.play(audio);
  }

  void increment() {
    if (count < limit) {
      count++;
      LocalStorage.zikrCount = count;
      notifyListeners();
    }
  }

  void reset() {
    count = 0;
    LocalStorage.zikrCount = 0;
    notifyListeners();
  }

  void setLimit(int newLimit) {
    limit = newLimit;
    LocalStorage.zikrLimit = newLimit;
    reset();
  }

  double get progress => count / limit;
}
