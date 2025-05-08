import 'package:flutter/material.dart';

class DetailTabSelectorViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      print("Tab index updated to: $index");  // 디버깅용
      notifyListeners();
    }
  }
}
