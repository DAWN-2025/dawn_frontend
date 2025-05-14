import 'package:flutter/material.dart';
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
    required this.commentViewModel,
  });

  // 탭 인덱스 설정
  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  // 데이터 초기화
  void resetState() {
    _location = null;
    _isLoading = false;
    _errorMessage = null;
    _selectedTabIndex = 0;
    notifyListeners();
  }

  // 주소 포맷팅
  String get formattedDescription {
    if (_location == null) return 'No description available';
    return '''
Address       |  ${_location!.address ?? 'N/A'}
Hours         |  ${_location!.openTime ?? 'N/A'} - ${_location!.closeTime ?? 'N/A'}
Phone         |  ${_location!.phoneNum ?? 'N/A'}
Exhibition    |  ${_location!.exhibitionTime ?? 'N/A'}
Available     |  ${_location!.available ?? 'N/A'}
Translate     |  ${_location!.translate ?? 'N/A'}
''';
  }

  // 위치 상세 정보 가져오기
  Future<void> fetchLocationDetail(int locationId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // 상세 정보 가져오기
      final LocationDetail? result = await repository.getLocationDetail(locationId);

      if (result != null) {
        _location = result;
        _errorMessage = null;
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
