import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/location_detail_model.dart';
import 'package:dawn_frontend/src/domain/repositories/details/location_detail_repository.dart';

class LocationDetailViewModel extends ChangeNotifier {
  final LocationDetailRepository repository;

  LocationDetailViewModel({required this.repository});

  LocationDetail? _location;
  bool _isLoading = false;
  String? _errorMessage;
  int _selectedTabIndex = 0;

  LocationDetail? get location => _location;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get selectedTabIndex => _selectedTabIndex;

  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  String get formattedDescription => _location?.getFormattedDescription() ?? '';

  Future<void> fetchLocationDetail(int locationId) async {
    _setLoadingState(true);
    try {
      final locationDetail = await repository.fetchLocationDetail(locationId);
      if (locationDetail != null) {
        _location = locationDetail;
      } else {
        _setErrorState("No location found for ID: $locationId");
      }
    } catch (e) {
      _setErrorState('Failed to load location details: $e');
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
