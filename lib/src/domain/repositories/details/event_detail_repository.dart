import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';

class EventDetailRepository {
  Future<EventDetail> loadEventDetail() async {
    final jsonStr =
        await rootBundle.loadString('assets/constants/event_details.json');
    final jsonMap = json.decode(jsonStr);
    return EventDetail.fromJson(jsonMap);
  }
}
