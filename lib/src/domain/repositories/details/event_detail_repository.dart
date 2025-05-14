import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/data/services/event_service.dart';

class EventDetailRepository {
  final EventService _eventService = EventService();

  // 이벤트 상세 정보 가져오기
  Future<EventDetail> fetchEventDetail(int eventId) async {
    try {
      return await _eventService.fetchEventDetail(eventId);
    } catch (e) {
      print('Error fetching event details from repository: $e');
      throw Exception('Failed to load event details: $e');
    }
  }
}
