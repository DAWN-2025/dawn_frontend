import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';
import 'package:dawn_frontend/src/data/clients/dio_client.dart';

class EventDetailRepository {
  final DioClient _dioClient = DioClient();
  Future<EventDetail> fetchEventDetail(int eventId) async {
    try {
      final response = await _dioClient.dio.get(
        '/event/viewEventInfo',
        queryParameters: {'id': eventId},
      );
      if (response.statusCode == 200) {
        return EventDetail.fromJson(response.data);
      } else {
        throw Exception('Failed to load event detail');
      }
    } catch (e) {
      throw Exception('Failed to load event details: $e');
    }
  }


  
}
