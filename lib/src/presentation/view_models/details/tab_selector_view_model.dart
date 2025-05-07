import 'package:flutter/material.dart';

class TabSelectorViewModel extends ChangeNotifier {
  int _selectedIndex;

  // 기본값으로 0, 혹은 외부에서 초기값 주입 가능
  TabSelectorViewModel({int initialIndex = 0}) : _selectedIndex = initialIndex;

  int get selectedIndex => _selectedIndex;

  // 초기화 메서드 추가
  void resetIndex() {
    _selectedIndex = 0;
    notifyListeners();
  }

  // 인덱스 설정
  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }
}
