import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';
import 'package:dawn_frontend/src/data/clients/dio_client.dart';

class LocationCardRepository {
  final DioClient _dioClient = DioClient();

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
}