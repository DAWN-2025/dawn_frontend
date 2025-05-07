import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/domain/repositories/details/event_detail_repository.dart';

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
    _selectedTabIndex = index;
    notifyListeners();
  }

  Future<void> fetchEventDetail() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _event = await repository.loadEventDetail();
    } catch (e) {
      _errorMessage = 'Failed to load event details';
    }

    _isLoading = false;
    notifyListeners();
  }
}
