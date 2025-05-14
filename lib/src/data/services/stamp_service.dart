import 'package:dio/dio.dart';
import 'package:dawn_frontend/src/data/storage/secure_storage.dart';
import '../../core/utils/log.dart';
import '../clients/dio_client.dart';
import '../models/stamp_card_model.dart';

class StampService {
  final Dio _dio;

  StampService() : _dio = DioClient().dio;

  // 스탬프 카드 목록 가져오기
  Future<List<StampCard>> fetchStampCards() async {
    try {
      final token = await SecureStorage.getJwt();
      final response = await _dio.get('/stamp/getStampImage',options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ));

      debugLog('응답 상태 코드: ${response.statusCode}');
      debugLog('스탬프 목록 응답 데이터: ${response.data}');

      if (response.statusCode == 200) {
        // 응답이 List인지 확인
        if (response.data is List) {
          // List<dynamic>을 List<Map<String, dynamic>>로 안전하게 변환
          List<StampCard> stampCards = (response.data as List)
              .map((item) => StampCard.fromJson(item as Map<String, dynamic>))
              .toList();
          return Future.value(stampCards);
        } else {
          debugLog('잘못된 데이터 형식: ${response.data.runtimeType}');
          return Future.value([]);
        }
      } else {
        debugLog('스탬프 목록 가져오기 실패');
        return Future.value([]);
      }
    } on DioException catch (e) {
      debugLog('Dio 에러 발생: ${e.message}');
      return Future.value([]);
    } catch (e) {
      debugLog('알 수 없는 에러: $e');
      return Future.value([]);
    }
  }
}
