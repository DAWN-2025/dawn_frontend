import 'package:dawn_frontend/src/data/models/stamp_card_model.dart';
import 'package:dawn_frontend/src/data/services/stamp_service.dart';

class StampCardRepository {
  final StampService _stampService = StampService();

  // 스탬프 카드 목록 가져오기
  Future<List<StampCard>> fetchStampCards() async {
    try {
      // await로 비동기 반환값 명시
      final List<StampCard> stampCards = await _stampService.fetchStampCards();
      return stampCards;
    } catch (e) {
      print('Error in repository while fetching stamp cards: $e');
      return [];
    }
  }
}