import 'package:flutter/material.dart';
import '../../../data/models/map/SearchEventResult.dart';
import '../../../data/models/map/SearchLocationResult.dart';
import '../../../data/services/search_service.dart';

class SearchResultViewModel extends ChangeNotifier {
  final SearchService _searchService = SearchService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SearchLocationResult> _locationResults = [];
  List<SearchEventResult> _eventResults = [];

  List<SearchLocationResult> get locationResults => _locationResults;
  List<SearchEventResult> get eventResults => _eventResults;

  /// 장소 검색
  Future<void> fetchSearchResults(String keyword, String jwtToken) async {
    _setLoading(true);
    try {
      final jsonList = await _searchService.searchByKeyword(
        keyword: keyword,
        jwtToken: jwtToken,
      );

      _locationResults = jsonList
          .map((json) => SearchLocationResult.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint('📍 fetchSearchResults error: $e');
    }
    _setLoading(false);
  }

  /// 이벤트 검색
  Future<void> searchEventByKeyword(String keyword, String jwtToken) async {
    _setLoading(true);
    try {
      final jsonList = await _searchService.searchEventByKeyword(
        keyword: keyword,
        jwtToken: jwtToken,
      );

      _eventResults =
          jsonList.map((json) => SearchEventResult.fromJson(json)).toList();
    } catch (e) {
      debugPrint('📍 searchEventByKeyword error: $e');
    }
    _setLoading(false);
  }

  /// 검색 결과 초기화
  void clearResults() {
    _locationResults = [];
    _eventResults = [];
    notifyListeners();
  }

  /// 로딩 상태 설정
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
