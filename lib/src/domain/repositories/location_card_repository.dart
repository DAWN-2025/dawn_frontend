import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';
import 'package:dawn_frontend/src/data/clients/dio_client.dart';

class LocationCardRepository {
  final DioClient _dioClient = DioClient();

  // 이벤트에 해당하는 장소 카드 목록 가져오기
  Future<List<LocationCardModel>> fetchEventLocations(int eventId) async {
    try {
      final response = await _dioClient.dio.get(
        '/location/viewLocationByEvent',
        queryParameters: {'eventId': eventId},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((item) => LocationCardModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load event locations');
      }
    } catch (e) {
      throw Exception('Error fetching event locations: $e');
    }
  }


  // 방문 여부 체크
  Future<bool> checkVisited(int locationSeq, int userSeq) async {
    try {
      final response = await _dioClient.dio.get(
        '/letter/byLocation',
        queryParameters: {
          'locationSeq': locationSeq,
          'userSeq': userSeq,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        // 방문 여부를 판별: 데이터가 존재하면 방문한 것으로 처리
        return data.isNotEmpty;
      } else {
        throw Exception('Failed to check visited status');
      }
    } catch (e) {
      throw Exception('Error checking visited status: $e');
    }
  }
}