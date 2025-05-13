import 'dart:convert';
import 'package:dawn_frontend/src/data/clients/dio_client.dart';
import 'package:dawn_frontend/src/data/models/location_detail_model.dart';
import 'package:dawn_frontend/src/core/utils/constants/api_constants.dart';

class LocationDetailRepository {
  final DioClient _dioClient = DioClient();

  Future<LocationDetail?> fetchLocationDetail(int locationId) async {
    try {
      // API 엔드포인트 설정
      final response = await _dioClient.dio.get(
        '/location/viewLocationByInfo',
        queryParameters: {'id': locationId},
      );

      // 상태 코드 확인
      if (response.statusCode == 200) {
        final Map<String, dynamic> locationData = response.data;

        print("Matched location data: $locationData");

        // LocationDetail 모델로 변환하여 반환
        return LocationDetail.fromJson(locationData);
      } else {
        print("Failed to load location details. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching location details: $e");
      throw Exception('Failed to load location details: $e');
    }
  }
}
