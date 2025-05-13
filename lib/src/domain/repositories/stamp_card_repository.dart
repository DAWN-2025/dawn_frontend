import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/data/models/stamp_card_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/stamp_card_view_model.dart';
import 'package:dawn_frontend/src/core/utils/constants/api_constants.dart';
import 'package:dawn_frontend/src/data/clients/dio_client.dart';

class StampCardRepository {
  final DioClient _dioClient = DioClient();

  Future<List<StampCard>> fetchStampCards() async {
    try {
      final response = await _dioClient.dio.get(
        '/stamp/getStampImage',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => StampCard.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load stamp cards');
      }
    } catch (e) {
      throw Exception('Error fetching stamp cards: $e');
    }
  }
}