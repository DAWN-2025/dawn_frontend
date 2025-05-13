import 'package:flutter/material.dart';

class StampCardViewModel extends ChangeNotifier {
  String? navigationPath;

  void handleCardTap(int eventSeq) {
    // 예시로 네비게이션 경로를 설정
    navigationPath = '/event-detail/$eventSeq';
    notifyListeners();
  }

  void clearNavigation() {
    navigationPath = null;
    notifyListeners();
  }
}
