import 'package:flutter/material.dart';

import '../core/storage/local_storage.dart';

class LanguageProvider extends ChangeNotifier {
  Locale locale = Locale(LocalStorage.language);

  void setLanguage(String code) {
    locale = Locale(code);
    LocalStorage.language = code;
    notifyListeners();
  }
}
