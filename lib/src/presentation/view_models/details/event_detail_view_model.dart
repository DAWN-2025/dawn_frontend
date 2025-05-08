import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/domain/repositories/event_detail_repository.dart';
import 'package:dawn_frontend/src/presentation/view_models/location_card_view_model.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';

class EventDetailViewModel extends ChangeNotifier {
  final EventDetailRepository repository;
  List<LocationCardViewModel> locationViewModels = [];
  List<int> visitedLocationSeqs = [];

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
    if (_selectedTabIndex != index) {
      _selectedTabIndex = index;
      notifyListeners();
    }
  }

  void initializeLocations(List<LocationCardModel> locations) {
    locationViewModels = locations
        .map((location) => LocationCardViewModel(model: location))
        .toList();
    notifyListeners();
  }

  Future<void> fetchEventDetail(int eventId, int userSeq) async {
    _setLoadingState(true);

    try {
      _event = await repository.fetchEventDetail(eventId);
      visitedLocationSeqs = await repository.fetchVisitedLocations(userSeq);
      List<LocationCardModel> locations = await repository.fetchEventLocations(visitedLocationSeqs);

      initializeLocations(locations);
      print("Loaded event details: ${_event?.name}");
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
