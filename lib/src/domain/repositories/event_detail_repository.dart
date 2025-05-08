import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';

class EventDetailRepository {
  Future<EventDetail> fetchEventDetail(int eventId) async {
    try {
      final String response = await rootBundle.loadString('assets/constants/event_details.json');
      final Map<String, dynamic> data = jsonDecode(response);
      return EventDetail.fromJson(data);
    } catch (e) {
      throw Exception('Failed to load event details: $e');
    }
  }

  Future<List<int>> fetchVisitedLocations(int userSeq) async {
    try {
      final String response = await rootBundle.loadString('assets/constants/visited_locations.json');
      final List<dynamic> visitedData = jsonDecode(response);
      return visitedData
          .where((item) => item is Map<String, dynamic>)
          .map((item) => item['locationSeq'] as int?)
          .whereType<int>()
          .toList();
    } catch (e) {
      throw Exception('Failed to load visited locations: $e');
    }
  }

  Future<List<LocationCardModel>> fetchEventLocations(List<int> visitedLocationSeqs) async {
    try {
      final String locationsResponse = await rootBundle.loadString('assets/constants/event_locations.json');
      final List<dynamic> locationsData = jsonDecode(locationsResponse);
      return locationsData
          .where((item) => item is Map<String, dynamic>)
          .map((item) => LocationCardModel.fromJson(item, visitedLocationSeqs))
          .toList();
    } catch (e) {
      throw Exception('Failed to load location details: $e');
    }
  }
}
