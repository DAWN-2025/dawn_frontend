import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dawn_frontend/src/data/storage/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/clients/dio_client.dart';
import 'letter_result_test_screen.dart';

class AiTestScreen extends StatefulWidget {
  const AiTestScreen({super.key});

  @override
  State<AiTestScreen> createState() => _AiTestScreen();
}

class _AiTestScreen extends State<AiTestScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _jwtToken;
  String _responseMessage = '';
  final Dio _dio = DioClient().dio;

  int _chatCount = 0;
  int? _lastChatSeq;
  int? _lastLocationSeq;

  @override
  void initState() {
    super.initState();
    _loadJwtToken();
  }

  Future<void> _loadJwtToken() async {
    final token = await SecureStorage.getJwt();
    setState(() {
      _jwtToken = token;
    });
  }

  Future<void> _sendToBackend() async {
    final inputText = _controller.text.trim();

    if (_jwtToken == null) {
      setState(() {
        _responseMessage = 'JWT 토큰이 로드되지 않았습니다.';
      });
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _responseMessage = 'Firebase 로그인된 유저가 없습니다.';
      });
      return;
    }

    final userUid = user.uid;

    if (inputText.isEmpty) {
      setState(() {
        _responseMessage = '입력값이 비어 있습니다.';
      });
      return;
    }

    final requestBody = {
      "userUid": userUid,
      "locationSeq": 1,
      "question": inputText,
    };

    try {
      final response = await _dio.post(
        '/rag',
        options: Options(
          headers: {'Authorization': 'Bearer ${_jwtToken!.trim()}'},
        ),
        data: requestBody,
      );

      final data = response.data;

      setState(() {
        _responseMessage = '전송 성공';
        _chatCount++;
        _lastChatSeq = data['chatSeq'];
        _lastLocationSeq = data['locationSeq'];
      });

      // 대화가 3회에 도달하면 다음 화면으로 이동
      if (_chatCount >= 3 && _lastChatSeq != null && _lastLocationSeq != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LetterResultTestScreen(
              jwtToken: _jwtToken!,
              chatSeq: _lastChatSeq!,
              locationSeq: _lastLocationSeq!,
            ),
          ),
        );
      }
    } on DioException catch (e) {
      setState(() {
        _responseMessage =
        '오류 발생: ${e.response?.statusCode} - ${e.response?.data}';
      });
    } catch (e) {
      setState(() {
        _responseMessage = '전송 실패: $e';
      });
    }

    // 요청 정보 디버깅 출력
    debugPrint("요청 전송 정보:");
    debugPrint("JWT Token: ${_jwtToken?.substring(0, 20)}...");
    debugPrint("userUid: $userUid");
    debugPrint("Request Body: ${jsonEncode(requestBody)}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('백엔드 전송 테스트')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: '질문을 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendToBackend,
              child: const Text('백엔드에 전송'),
            ),
            const SizedBox(height: 16),
            Text(_responseMessage),
          ],
        ),
      ),
    );
  }
}
