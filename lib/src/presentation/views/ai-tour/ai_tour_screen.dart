import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/ai-tour/ai_tour_view_model.dart';

class AiTourScreen extends StatelessWidget {
  const AiTourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AiTourViewModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text('AI Tour')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
                        final chat = viewModel.chatMessages[viewModel.chatMessages.length - 1 - index];
                        final isUser = chat.sender == 'User';
                        return Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isUser ? Colors.blue[300] : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              chat.message,
                              style: TextStyle(color: isUser ? Colors.white : Colors.black),
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
      ),
    );
  }
}
