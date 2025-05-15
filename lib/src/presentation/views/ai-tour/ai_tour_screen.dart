import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:dawn_frontend/src/presentation/view_models/ai-tour/ai_tour_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/common/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/common/custom_top_app_bar.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class AiTourScreen extends StatelessWidget {
  final int locationSeq;

  const AiTourScreen({super.key, required this.locationSeq});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomTopAppBar(),
      resizeToAvoidBottomInset: true,
      body: Consumer<AiTourViewModel>(
        builder: (context, viewModel, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/location-jeonil.jpeg',
                  fit: BoxFit.cover,
                  opacity: AlwaysStoppedAnimation(0.1),
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        key: UniqueKey(),
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
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: viewModel.inputController,
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
                                await context
                                    .read<AiTourViewModel>()
                                    .sendMessage(context);
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
          );
        },
      ),
    );
  }
}
