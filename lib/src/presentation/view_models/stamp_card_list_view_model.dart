import 'package:dawn_frontend/src/data/models/stamp_card_model.dart';
import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/presentation/view_models/stamp_card_view_model.dart';
import 'package:dawn_frontend/src/domain/repositories/stamp_card_repository.dart';

class StampCardListViewModel extends ChangeNotifier {
  final StampCardRepository _repository;
  List<StampCard> stampCards = [];
  bool isLoading = false;
  String errorMessage = '';

  // 수정: 기본 생성자에서 Repository를 명시적으로 받음
  StampCardListViewModel({required StampCardRepository repository})
    : _repository = repository;

  // 비동기 데이터 로드 함수
  Future<void> loadStampCards() async {
    try {
      isLoading = true;
      errorMessage = '';
      notifyListeners();  // 데이터 로드 시작 알림

      stampCards = await _repository.fetchStampCards();
      isLoading = false;
      notifyListeners();  // 데이터 로드 완료 알림
    } catch (e) {
      errorMessage = 'Failed to load stamps: ${e.toString()}';
      isLoading = false;
      notifyListeners();  // 오류 발생 알림
    }
  }

  // 특정 스탬프 방문 여부 확인
bool isStampVisited(int eventId) {
  final stamp = stampCards.firstWhere(
    (card) => card.eventId == eventId,
    orElse: () => StampCard(eventId: eventId, eventName: '', eventNameEng: '', eventStampImg: '', isVisited: false),
  );
  return stamp.isVisited ?? false;
}
}
