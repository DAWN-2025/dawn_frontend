import 'package:dio/dio.dart';
import 'package:dawn_frontend/src/data/clients/dio_client.dart';

class AiTourService {
  final Dio _dio = DioClient().dio;

  Future<Map<String, dynamic>> sendQuestion(
    String jwtToken,
    String userUid,
    int locationSeq,
    String question,
  ) async {
    final requestBody = {
      "userUid": userUid.toString(),
      "locationSeq": locationSeq,
      "question": question.toString(),
    };
    try {
      print('Request Body: $requestBody');
      final response = await _dio.post(
        '/rag',
        options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
        data: requestBody,
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      return {
        'chatAnswer': 'Error: ${e.response?.statusCode} - ${e.response?.data}',
      };
    } catch (e) {
      return {'chatAnswer': 'Error: $e'};
    }
  }

  // 📝 편지 생성 API
  Future<Map<String, dynamic>> createLetter(
    String jwtToken,
    String userUid,
    int locationSeq,
  ) async {
    final requestBody = {
      "userUid": userUid,
      "locationSeq": locationSeq,
    };
    try {
      print('Create Letter Request Body: $requestBody');
      final response = await _dio.post(
        '/letter/create',
        options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
        data: requestBody,
      );
      print('Create Letter Response: ${response.data}');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print('DioException: ${e.response?.statusCode} - ${e.response?.data}');
      return {
        'error': 'Error: ${e.response?.statusCode} - ${e.response?.data}',
      };
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }
}
