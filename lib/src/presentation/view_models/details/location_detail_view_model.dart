import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/data/models/location_detail_model.dart';
import 'package:dawn_frontend/src/domain/repositories/details/location_detail_repository.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/comment_view_model.dart';

class LocationDetailViewModel extends ChangeNotifier {
  final LocationDetailRepository repository;
  final CommentViewModel commentViewModel;

  LocationDetail? _location;
  bool _isLoading = false;
  String? _errorMessage;
  int _selectedTabIndex = 0;

  LocationDetail? get location => _location;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get selectedTabIndex => _selectedTabIndex;

  LocationDetailViewModel({
    required this.repository,
    required this.commentViewModel,  // 수정 부분
  });

  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  String get formattedDescription {
    if (_location == null) return 'No description available';
    return '''
Address  |  ${_location!.address}
Hours  |  ${_location!.openTime} - ${_location!.closeTime}
Phone  |  ${_location!.phoneNum}
Exhibition tour  |  ${_location!.exhibitionTime}
Available  |  ${_location!.available == 'Y' ? 'Yes' : 'No'}
Translate  |  ${_location!.translate == 'Y' ? 'Yes' : 'No'}
''';
  }

  Future<void> fetchLocationDetail(int locationId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString('assets/constants/location_details.json');
      final Map<String, dynamic> data = jsonDecode(response);

      final List<dynamic> locations = data['locations'] ?? [];
      final locationData = locations.firstWhere(
        (item) => item['id'] == locationId,
        orElse: () => null,
      );

      if (locationData != null) {
        _location = LocationDetail.fromJson(locationData);
      } else {
        _errorMessage = 'Location not found';
      }
    } catch (e) {
      _errorMessage = 'Failed to load location details: $e';
      print('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
