class Letter {
  final int seq;
  final String userUid;
  final int locationSeq;
  final String content;
  final DateTime letterTime;

  Letter({
    required this.seq,
    required this.userUid,
    required this.locationSeq,
    required this.content,
    required this.letterTime,
  });

  factory Letter.fromJson(Map<String, dynamic> json) {
    return Letter(
      seq: json['seq'] ?? 0,
      userUid: json['userUid'] ?? '',
      locationSeq: json['locationSeq'] ?? 0,
      content: json['content'] ?? 'No content',
      letterTime: DateTime.tryParse(json['letterTime'] ?? '') ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'Letter(seq: $seq, userUid: $userUid, locationSeq: $locationSeq, content: $content, letterTime: $letterTime)';
  }
}
