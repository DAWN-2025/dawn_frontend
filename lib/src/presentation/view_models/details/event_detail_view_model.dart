import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/domain/repositories/event_detail_repository.dart';
import 'package:dawn_frontend/src/presentation/view_models/location_card_view_model.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';

class EventDetailViewModel extends ChangeNotifier {
  final EventDetailRepository repository;
  List<LocationCardViewModel> locationViewModels = [];

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

  void initializeLocations(List<Location> locations) {
    locationViewModels =
        locations
            .map(
              (location) => LocationCardViewModel(
                model: LocationCardModel(
                  name: location.name,
                  address: location.address,
                  // latitude: location.latitude,
                  // longitude: location.longitude,
                ),
              ),
            )
            .toList();
    notifyListeners();
  }

  void toggleLocationVisited(String locationName) {
    final viewModel = locationViewModels.firstWhere(
      (vm) => vm.model.name == locationName,
      orElse:
          () => LocationCardViewModel(
            model: LocationCardModel(
              name: locationName,
              address: '',
              // latitude: 0,
              // longitude: 0,
            ),
          ),
    );
    viewModel.toggleVisited();
    notifyListeners();
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
