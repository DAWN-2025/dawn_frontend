import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/data/models/comment_model.dart';

class CommentRepository {
  final String _filePath = 'assets/constants/comment_list.json';

  /// 댓글 불러오기
  Future<List<CommentModel>> fetchComments() async {
    try {
      final String response = await rootBundle.loadString(_filePath);
      final Map<String, dynamic> data = jsonDecode(response);
      final List<dynamic> commentData = data['comments'] ?? [];
      
      return commentData
          .map((comment) => CommentModel.fromJson(comment))
          .toList();
    } catch (e) {
      print('Error loading comments: $e');
      return [];
    }
  }

  /// 댓글 추가
  Future<CommentModel> addComment(String text) async {
    final newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch,
      userEmail: 'user@example.com',
      comment: text,
      createdAt: DateTime.now(),
      edited: false,
      likes: 0,
      myComment: true,
      visited: false,
      deleted: false,
    );

    try {
      final comments = await fetchComments();
      comments.add(newComment);
      await _saveComments(comments);
      return newComment;
    } catch (e) {
      print('Error adding comment: $e');
      throw Exception('Failed to add comment');
    }
  }

  /// 댓글 수정
  Future<CommentModel> updateComment(int id, String newComment) async {
    try {
      final comments = await fetchComments();
      final index = comments.indexWhere((comment) => comment.id == id);
      if (index != -1) {
        comments[index] = comments[index].copyWith(
          comment: newComment,
          edited: true,
        );
        await _saveComments(comments);
        return comments[index];
      }
      throw Exception('Comment not found');
    } catch (e) {
      print('Error updating comment: $e');
      throw Exception('Failed to update comment');
    }
  }

  /// 댓글 삭제
  Future<void> deleteComment(int id) async {
    try {
      final comments = await fetchComments();
      comments.removeWhere((comment) => comment.id == id);
      await _saveComments(comments);
    } catch (e) {
      print('Error deleting comment: $e');
      throw Exception('Failed to delete comment');
    }
  }

  /// 좋아요 상태 업데이트
  Future<void> updateLikeStatus(int id, int likes) async {
    try {
      final comments = await fetchComments();
      final index = comments.indexWhere((comment) => comment.id == id);
      if (index != -1) {
        comments[index] = comments[index].copyWith(likes: likes);
        await _saveComments(comments);
      }
    } catch (e) {
      print('Error updating like status: $e');
      throw Exception('Failed to update like status');
    }
  }

  /// 댓글 데이터 저장
  Future<void> _saveComments(List<CommentModel> comments) async {
    try {
      final String jsonString = jsonEncode({'comments': comments.map((c) => c.toJson()).toList()});
      print('Saving comments: $jsonString');
      // 실제 파일 저장 로직 필요 (Flutter에서는 assets 파일 쓰기 제한)
    } catch (e) {
      print('Error saving comments: $e');
    }
  }
}
