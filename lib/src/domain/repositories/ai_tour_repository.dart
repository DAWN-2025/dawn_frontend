import 'package:dawn_frontend/src/data/models/ai-tour/ai_tour_model.dart';
import 'package:dawn_frontend/src/data/services/ai_tour_service.dart';

class AiTourRepository {
  final AiTourService _service = AiTourService();

  Future<AiTourModel> getAiTourResponse(
    String jwtToken,
    String userUid,
    int locationSeq,
    String question,
  ) async {
    try {
      final data = await _service.sendQuestion(
        jwtToken,
        userUid,
        locationSeq,
        question,
      );

      return AiTourModel.fromJson(data); // 모델로 직접 변환
    } catch (e) {
      return AiTourModel(
        chatSeq: 0,
        userUid: userUid,
        locationSeq: locationSeq,
        chatQuestion: question,
        chatAnswer: 'Error: $e',
      );
    }
  }

  Future<Map<String, dynamic>> createLetter(
    String jwtToken,
    String userUid,
    int locationSeq,
  ) async {
    return await _service.createLetter(jwtToken, userUid, locationSeq);
  }
}
