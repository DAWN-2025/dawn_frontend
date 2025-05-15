import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/domain/repositories/ai_tour_repository.dart';
import 'package:dawn_frontend/src/data/models/ai-tour/ai_tour_model.dart';
import 'package:dawn_frontend/src/data/models/ai-tour/chat_message.dart';
import 'package:dawn_frontend/src/data/storage/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dawn_frontend/src/presentation/widgets/modals/tour_end_modal.dart';
import 'package:go_router/go_router.dart';
import 'package:dawn_frontend/src/data/services/stamp_service.dart';  // StampService 임포트

class AiTourViewModel extends ChangeNotifier {
  int locationSeq;
  final AiTourRepository _repository = AiTourRepository();
  final StampService _stampService = StampService();  // StampService 인스턴스
  final TextEditingController inputController = TextEditingController();

  List<ChatMessage> chatMessages = [];
  int chatCount = 0;
  String? jwtToken;
  String? userUid;

  AiTourViewModel({required this.locationSeq}) {
    _loadAuthInfo();
  }

  // JWT 토큰과 사용자 UID를 로드하는 함수
  Future<void> _loadAuthInfo() async {
    try {
      jwtToken = await SecureStorage.getJwt();
      final user = FirebaseAuth.instance.currentUser;
      userUid = user?.uid;
      notifyListeners();
    } catch (e) {
      _addMessage('System', '인증 정보 로드 실패: $e');
    }
  }

  // 메시지 추가 함수
  void _addMessage(String sender, String message) {
    chatMessages.add(ChatMessage(sender: sender, message: message));
    notifyListeners();
  }

  // 전송 버튼 클릭 시 호출
  Future<void> sendMessage(BuildContext context) async {
    String message = inputController.text.trim();

    if (message.isEmpty) return;

    // 사용자 메시지 추가
    _addMessage('User', message);
    inputController.clear();

    if (jwtToken == null || userUid == null) {
      _addMessage('System', '인증 정보를 불러오지 못했습니다.');
      return;
    }

    try {
      // AI 응답 받기
      final AiTourModel model = await _repository.getAiTourResponse(
        jwtToken!,
        userUid!,
        locationSeq,
        message,
      );

      // AI 응답 화면에 추가
      _addMessage('AI', model.chatAnswer);

      // 대화 횟수 증가 후 조건 확인
      chatCount++;
      if (chatCount >= 3) {
        await _createLetter(context);
      }
    } catch (e) {
      _addMessage('System', 'Error: $e');
    }
  }

  // 📝 편지 생성 함수 (스탬프 생성 추가)
  Future<void> _createLetter(BuildContext context) async {
    try {
      final response = await _repository.createLetter(jwtToken!, userUid!, locationSeq);

      if (response.containsKey('seq')) {
        locationSeq = response['locationSeq'];

        await _stampService.createStamp(locationSeq, 1);  // 스탬프 생성 API 호출

        _showTourEndModal(context);
      } else {
        _addMessage('System', '편지 생성 실패: ${response['error']}');
      }
    } catch (e) {
      _addMessage('System', '편지 생성 오류: $e');
    }
  }

  // 모달 표시
  void _showTourEndModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return TourEndModal(
          onCheckLetter: () {
            Navigator.of(dialogContext).pop();
            Future.microtask(() {
              context.go('/event-detail/1');
              context.push('/letter/$locationSeq');
            });
          },
          onGoToHome: () {
            Navigator.of(dialogContext).pop();
            Future.microtask(() {
              context.go('/');
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}
