import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/presentation/view_models/stamp_card_view_model.dart';
import 'package:dawn_frontend/src/domain/repositories/stamp_card_repository.dart';

class StampCardListViewModel extends ChangeNotifier {
  final StampCardRepository repository;
  List<StampCardViewModel> stampCards = [];

  StampCardListViewModel({required this.repository});

  Future<void> loadStampCards() async {
    stampCards = await repository.fetchStampCards();
    notifyListeners(); // UI 업데이트 알림
  }
}