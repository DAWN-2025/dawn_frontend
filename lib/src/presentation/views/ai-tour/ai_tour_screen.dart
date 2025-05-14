import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:dawn_frontend/src/presentation/view_models/ai-tour/ai_tour_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_top_app_bar.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class AiTourScreen extends StatelessWidget {
  const AiTourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomTopAppBar(),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/images/location-jeonil.jpeg',
              fit: BoxFit.cover,
              opacity: AlwaysStoppedAnimation(0.1),
            ),
          ),
          // 반투명 블러 레이어
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          // 채팅과 입력 필드
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
            child: Column(
              children: [
                // 채팅 리스트
                Expanded(
                  child: Consumer<AiTourViewModel>(
                    builder: (context, viewModel, child) {
                      return ListView.builder(
                        reverse: true,
                        itemCount: viewModel.chatMessages.length,
                        itemBuilder: (context, index) {
                          final chat =
                              viewModel.chatMessages[viewModel
                                      .chatMessages
                                      .length -
                                  1 -
                                  index];
                          final isUser = chat.sender == 'User';

                          return Align(
                            alignment:
                                isUser
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 8.0,
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                chat.message,
                                textAlign:
                                    isUser ? TextAlign.end : TextAlign.start,
                                style: typography.AppTextStyle.bodyText
                                    .copyWith(
                                      fontSize: isUser ? 18 : 20,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // 입력 필드와 전송 버튼
                Consumer<AiTourViewModel>(
                  builder: (context, viewModel, child) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: viewModel.inputController,
                            decoration: const InputDecoration(
                              labelText: '질문을 입력하세요',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () async {
                            await viewModel.sendMessage(context);
                          },
                          child: const Text('전송'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
