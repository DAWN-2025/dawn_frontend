import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/comment_model.dart';
import 'package:dawn_frontend/src/domain/repositories/details/comment_repository.dart';

class CommentViewModel extends ChangeNotifier {
  final CommentRepository commentRepository;

  List<CommentModel> _comments = [];
  List<CommentModel> get comments => _comments;

  CommentViewModel({required this.commentRepository});

  /// 댓글 목록 불러오기
  Future<void> fetchComments() async {
    try {
      _comments = await commentRepository.fetchComments();
      notifyListeners();
    } catch (e) {
      print('Error loading comments: $e');
    }
  }

  /// 댓글 추가
  void addComment(String text) async {
    try {
      final newComment = await commentRepository.addComment(text);
      _comments.insert(0, newComment); // 최신 댓글이 상단에 표시되도록
      notifyListeners();
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  /// 댓글 수정
  void updateComment(int id, String newComment) async {
    try {
      final updatedComment = await commentRepository.updateComment(
        id,
        newComment,
      );
      final index = _comments.indexWhere((comment) => comment.id == id);
      if (index != -1) {
        _comments[index] = updatedComment;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating comment: $e');
    }
  }

  /// 댓글 삭제
  void deleteComment(int id) async {
    try {
      await commentRepository.deleteComment(id);
      _comments.removeWhere((comment) => comment.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting comment: $e');
    }
  }

  /// 좋아요 토글
  void toggleLike(int id) async {
    try {
      final index = _comments.indexWhere((comment) => comment.id == id);
      if (index != -1) {
        final currentLikes = _comments[index].likes;
        final isLiked = _comments[index].isLiked;

        // 좋아요 상태 반전
        final updatedLikes = isLiked ? currentLikes - 1 : currentLikes + 1;
        final updatedComment = _comments[index].copyWith(
          likes: updatedLikes,
          isLiked: !isLiked,
        );

        _comments[index] = updatedComment;
        notifyListeners();
      }
    } catch (e) {
      print('Error toggling like: $e');
    }
  }
}
