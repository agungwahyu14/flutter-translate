import 'package:flutter/material.dart';
import 'package:flutter_translate/home/models/translate_history.dart';

class HistoryProvider with ChangeNotifier {
  final List<TranslationHistory> _history = [];

  List<TranslationHistory> get history => _history;

  void addHistory(String sourceText, String translatedText) {
    _history.add(TranslationHistory(
      sourceText: sourceText,
      translatedText: translatedText,
    ));
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}
