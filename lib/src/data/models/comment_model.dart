class CommentModel {
  final int id;
  final String userEmail;
  final String comment;
  final DateTime createdAt;
  final bool edited;
  final int likes;
  final bool myComment;
  final bool visited;
  final bool deleted;
  final bool isLiked;

  CommentModel({
    required this.id,
    required this.userEmail,
    required this.comment,
    required this.createdAt,
    required this.edited,
    required this.likes,
    required this.myComment,
    required this.visited,
    required this.deleted,
    this.isLiked = false,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      userEmail: json['userEmail'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      edited: json['edited'],
      likes: json['likes'],
      myComment: json['myComment'],
      visited: json['visited'],
      deleted: json['deleted'],
      isLiked: json['isLiked'] ?? false, // 기본값 false로 설정
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userEmail': userEmail,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'edited': edited,
      'likes': likes,
      'myComment': myComment,
      'visited': visited,
      'deleted': deleted,
      'isLiked': isLiked,
    };
  }

  /// copyWith 메서드 업데이트
  CommentModel copyWith({
    int? id,
    String? userEmail,
    String? comment,
    DateTime? createdAt,
    bool? edited,
    int? likes,
    bool? myComment,
    bool? visited,
    bool? deleted,
    bool? isLiked, // 추가
  }) {
    return CommentModel(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      edited: edited ?? this.edited,
      likes: likes ?? this.likes,
      myComment: myComment ?? this.myComment,
      visited: visited ?? this.visited,
      deleted: deleted ?? this.deleted,
      isLiked: isLiked ?? this.isLiked, // 추가
    );
  }
}
