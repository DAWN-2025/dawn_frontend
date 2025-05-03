import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  void initializeApp() {
    _isInitialized = true;
    notifyListeners();
  }
}