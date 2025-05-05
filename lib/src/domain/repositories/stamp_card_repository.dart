import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/presentation/view_models/stamp_card_view_model.dart';

class StampCardRepository {
  Future<List<StampCardViewModel>> fetchStampCards() async {
    // JSON 파일 읽기
    final String response = await rootBundle.loadString('assets/constants/stamp_cards.json');
    final List<dynamic> data = json.decode(response);

    // JSON 데이터를 ViewModel 리스트로 변환
    return data.map((json) => StampCardViewModel.fromJson(json)).toList();
  }
}