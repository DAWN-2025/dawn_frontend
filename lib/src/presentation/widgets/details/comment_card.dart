import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dawn_frontend/src/data/models/comment_model.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onLike;
  final VoidCallback onReport;

  const CommentCard({
    Key? key,
    required this.comment,
    required this.onLike,
    required this.onReport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(204, 168, 200, 0.6),
                  Color.fromRGBO(169, 136, 169, 0.6),
                  Color.fromRGBO(127, 94, 137, 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.white.withOpacity(0.15),
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단: 유저 이메일과 신고 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment.userEmail,
                      style: typography.AppTextStyle.bodyTextPoppins.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: onReport,
                      child: const Text(
                        'report',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // 댓글 내용
                Text(
                  comment.comment,
                  style: typography.AppTextStyle.bodyTextPoppins.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                // 하단: 좋아요 수와 작성일자
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onLike,
                          child: SvgPicture.asset(
                            'assets/icons/like.svg',
                            width: 16,
                            height: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${comment.likes}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _formatDate(comment.createdAt),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}";
  }
}
