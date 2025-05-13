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

  Future<void> loadStampCards() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();
    try {
      stampCards = await _repository.fetchStampCards();
      notifyListeners();  // 성공 시 UI 업데이트
    } catch (e) {
      errorMessage = 'Failed to load stamps: ${e.toString()}';
      notifyListeners();  // 오류 시 UI 업데이트
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
