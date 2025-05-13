import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../data/clients/dio_client.dart'; // DioClient 사용

class LetterResultTestScreen extends StatefulWidget {
  final String jwtToken;
  final int chatSeq;
  final int locationSeq;

  const LetterResultTestScreen({
    super.key,
    required this.jwtToken,
    required this.chatSeq,
    required this.locationSeq,
  });

  @override
  State<LetterResultTestScreen> createState() => _LetterResultTestScreenState();
}

class _LetterResultTestScreenState extends State<LetterResultTestScreen> {
  String? _log;
  final Dio _dio = DioClient().dio; // 공통 DioClient 사용

  @override
  void initState() {
    super.initState();
    _requestLetter();
  }

  Future<void> _requestLetter() async {
    try {
      final response = await _dio.post(
        '/letter/create',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${widget.jwtToken}',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "chatSeq": widget.chatSeq,
          "locationSeq": widget.locationSeq,
        },
      );

      final data = response.data;
      debugPrint('Letter Response: $data');

      setState(() {
        _log = jsonEncode(data);
      });
    } on DioException catch (e) {
      debugPrint('요청 실패: ${e.message}');
      setState(() {
        _log = '오류: ${e.response?.statusCode} - ${e.response?.data}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('편지 결과')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(_log ?? '로딩 중...'),
        ),
      ),
    );
  }
}
