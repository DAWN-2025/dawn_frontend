import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/data/models/location_detail_model.dart';

class LocationDetailRepository {
  Future<LocationDetail?> fetchLocationDetail(int locationId) async {
    try {
      final String response = await rootBundle.loadString('assets/constants/location_details.json');
      
      // 루트 키 'locations'로 접근하여 리스트를 파싱
      final Map<String, dynamic> jsonData = jsonDecode(response);
      final List<dynamic> dataList = jsonData['locations'] ?? [];

      // 디버깅 로그 추가
      print("Loaded JSON data: $dataList");

      // ID 필터링 로직 수정
      final Map<String, dynamic>? locationData = dataList.firstWhere(
        (item) => item['id']?.toString() == locationId.toString(),
        orElse: () {
          print("Location with ID $locationId not found");
          return null;
        },
      );

      if (locationData != null) {
        print("Matched location data: $locationData");
        return LocationDetail.fromJson(locationData);
      } else {
        print("No location found for ID: $locationId");
        return null;
      }
    } catch (e) {
      print("Error loading location details: $e");
      throw Exception('Failed to load location details: $e');
    }
  }
}
