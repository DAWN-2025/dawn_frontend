import 'package:flutter/material.dart';
import '../../../data/services/search_service.dart';

class SearchResultViewModel extends ChangeNotifier {
  final SearchService _searchService = SearchService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchSearchResults(String keyword, String jwtToken) async {
    _isLoading = true;
    notifyListeners();

    try {
      // 현재는 JSON만 출력하고 반환값 없음
      await _searchService.searchByKeyword(
        keyword: keyword,
        jwtToken: jwtToken,
      );
    } catch (e) {
      // 필요 시 에러 로그 출력
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchEventByKeyword(String keyword, String jwtToken) async {
    _isLoading = true;
    notifyListeners();

    try {
      // 현재는 JSON만 출력하고 반환값 없음
      await _searchService.searchEventByKeyword(
        keyword: keyword,
        jwtToken: jwtToken,
      );
    } catch (e) {
      // 필요 시 에러 로그 출력
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearResults() {
    // 결과가 없기 때문에 초기화 할 것도 없음 (임시용)
    notifyListeners();
  }
}
