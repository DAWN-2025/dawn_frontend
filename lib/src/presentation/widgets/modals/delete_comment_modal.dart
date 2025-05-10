import 'package:flutter/material.dart';
import 'reusable_modal.dart';

void DeleteCommentModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReusableModal(
        title: 'Would you like to delete this comment?',
        primaryButtonText: 'Delete',
        secondaryButtonText: 'Cancel',
        onPrimaryPressed: () {
          print('Comment deleted!');
          // 댓글 삭제 관련 로직 추가
        },
        onSecondaryPressed: () => Navigator.of(context).pop(),
      );
    },
  );
}
