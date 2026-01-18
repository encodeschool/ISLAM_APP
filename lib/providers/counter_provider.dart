import 'package:flutter/material.dart';

import '../core/storage/local_storage.dart';

class CounterProvider extends ChangeNotifier {
  int count = LocalStorage.zikrCount;
  int limit = LocalStorage.zikrLimit;

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
