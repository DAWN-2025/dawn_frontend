import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'comment_card.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/comment_view_model.dart';

class CommentCardList extends StatelessWidget {
  const CommentCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.comments.isEmpty) {
          return const Center(
            child: Text(
              "No comments available",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0), // 간격 줄이기
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero, // 기본 여백 제거
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.comments.length,
            itemBuilder: (context, index) {
              final comment = viewModel.comments[index];
              return Column(
                children: [
                  CommentCard(
                    comment: comment,
                    onLike: () => viewModel.toggleLike(comment.id),
                    onReport: () => print("Report comment: ${comment.id}"),
                  ),
                  if (index ==
                      viewModel.comments.length - 1) // 마지막 아이템 뒤에 추가 공간
                    const SizedBox(height: 100), // 리스트 아래 공간
                ],
              );
            },
          ),
        );
      },
    );
  }
}
