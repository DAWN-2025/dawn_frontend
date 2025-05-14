import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:dawn_frontend/src/presentation/view_models/ai-tour/ai_tour_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_top_app_bar.dart';

class AiTourScreen extends StatelessWidget {
  const AiTourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomTopAppBar(
        ),
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
                                decoration: BoxDecoration(
                                  color:
                                      isUser
                                          ? Colors.blue[300]
                                          : Colors.grey[300]?.withOpacity(0.8),
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        isUser
                                            ? const Radius.circular(12)
                                            : const Radius.circular(0),
                                    topRight:
                                        isUser
                                            ? const Radius.circular(0)
                                            : const Radius.circular(12),
                                    bottomLeft: const Radius.circular(12),
                                    bottomRight: const Radius.circular(12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width *
                                      0.75, // 채팅 버블 최대 너비 제한
                                ),
                                child: Text(
                                  chat.message,
                                  style: TextStyle(
                                    color: isUser ? Colors.white : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 8),
                  // 입력 필드와 전송 버튼
                  Row(
                    children: [
                      // 입력 필드 (비율: 7)
                      Expanded(
                        flex: 8,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller:
                                context.read<AiTourViewModel>().inputController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              hintText: 'Type your message...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // 전송 버튼 (비율: 3)
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              await context.read<AiTourViewModel>().sendMessage(
                                context,
                              );
                            },
                            child: const Text(
                              'Send',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
