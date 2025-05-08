import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/domain/repositories/event_detail_repository.dart';

class EventDetailViewModel extends ChangeNotifier {
  final EventDetailRepository repository;

  EventDetailViewModel({required this.repository});

  EventDetail? _event;
  bool _isLoading = false;
  String? _errorMessage;
  int _selectedTabIndex = 0;

  EventDetail? get event => _event;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get selectedTabIndex => _selectedTabIndex;

  void setSelectedTabIndex(int index) {
    print("Setting tab index to: $index"); // 디버깅용
    if (_selectedTabIndex != index) {
      _selectedTabIndex = index;
      print("Tab index updated: $_selectedTabIndex"); // 디버깅용
      notifyListeners(); // 상태 변경 알림
    }
  }

  Future<void> fetchEventDetail() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _event = await repository.loadEventDetail();
      _event = _event?.copyWith(locations: _event?.locations ?? []);
    } catch (e) {
      _errorMessage = 'Failed to load event details';
    }

    _isLoading = false;
    notifyListeners();
  }
}
