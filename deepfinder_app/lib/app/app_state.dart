import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  bool _isPro = false;
  final List<String> _history = [];

  bool get isPro => _isPro;
  List<String> get history => List.unmodifiable(_history);

  void setPro(bool value) {
    if (_isPro == value) return;
    _isPro = value;
    notifyListeners();
  }

  void addToHistory(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    _history.remove(trimmed);
    _history.insert(0, trimmed);
    if (_history.length > 50) {
      _history.removeRange(50, _history.length);
    }
    notifyListeners();
  }

  void clearHistory() {
    if (_history.isEmpty) return;
    _history.clear();
    notifyListeners();
  }
}

