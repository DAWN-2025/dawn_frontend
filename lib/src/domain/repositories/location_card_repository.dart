import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';
import 'package:dawn_frontend/src/data/clients/dio_client.dart';
import 'package:dawn_frontend/src/data/services/location_service.dart';

class LocationCardRepository {
  final LocationService locationService = LocationService();

  // 이벤트 장소 목록 가져오기
  Future<List<LocationCardModel>> loadEventLocations(int eventId) async {
    try {
      List<LocationCardModel> locations = await locationService.fetchEventLocations(eventId);
      print('Loaded ${locations.length} location cards');

      if (locations.isEmpty) {
        print('No locations found for eventId: $eventId');
      }

      return locations;
    } catch (e) {
      print('Error loading event locations: $e');
      return [];
    }
  }

  // 방문 여부 확인
  Future<bool> checkVisited(int locationSeq, int userSeq) async {
    try {
      bool visited = await locationService.checkVisited(locationSeq, userSeq);
      print('Visited status for locationSeq $locationSeq: $visited');
      return visited;
    } catch (e) {
      print('Error checking visited status: $e');
      return false;
    }
  }
}
