import 'package:flutter/material.dart';

class StampCardViewModel extends ChangeNotifier {
  final String title;
  final String? imagePath;
  final int id;

  // 프라이빗 생성자
  StampCardViewModel._({
    required this.title,
    required this.imagePath,
    required this.id,
  });

  final ValueNotifier<String> _navigationPath = ValueNotifier('');

  // 팩토리 메서드: JSON 데이터를 기반으로 생성
  factory StampCardViewModel.fromJson(Map<String, dynamic> json) {
    return StampCardViewModel._(
      id: json['id'],
      title: json['title'],
      imagePath: json['imagePath'],
    );
  }

  ValueNotifier<String> get navigationPath => _navigationPath;

  Future<void> sendCardIdToBackend() async {
    // 백엔드 요청 처리
    debugPrint('sendCardIdToBackend completed with ID: $id');
  }

  // 화면 전환 요청
  Future<void> handleCardTap(int cardId) async {
    _navigationPath.value = '/event-detail/${cardId}';
    await sendCardIdToBackend();
  }

  // 화면 전환 완료 후 상태 초기화
  void clearNavigation() {
    _navigationPath.value = '';
  }
}
