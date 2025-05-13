import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/domain/repositories/details/event_detail_repository.dart';

class EventDetailViewModel extends ChangeNotifier {
  final EventDetailRepository repository;

  EventDetail? _event;
  bool _isLoading = false;
  String? _errorMessage;
  int _selectedTabIndex = 0;

  EventDetail? get event => _event;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get selectedTabIndex => _selectedTabIndex;

  EventDetailViewModel({required this.repository});

  void setSelectedTabIndex(int index) {
    if (_selectedTabIndex != index) {
      _selectedTabIndex = index;
      notifyListeners();
    }
  }

  Future<void> fetchEventDetail(int eventId) async {
    _setLoadingState(true);

    try {
      _event = await repository.fetchEventDetail(eventId);
      print("Loaded event details: ${_event?.name}");
      _errorMessage = null;
    } catch (e) {
      _setErrorState('Failed to load event details: $e');
    } finally {
      _setLoadingState(false);
    }
  }

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _setErrorState(String message) {
    _errorMessage = message;
    _isLoading = false;
    notifyListeners();
  }
}
