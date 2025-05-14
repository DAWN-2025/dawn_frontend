class AiTourModel {
  final int chatSeq;
  final String userUid;
  final int locationSeq;
  final String chatQuestion;
  final String chatAnswer;

  AiTourModel({
    required this.chatSeq,
    required this.userUid,
    required this.locationSeq,
    required this.chatQuestion,
    required this.chatAnswer,
  });

  factory AiTourModel.fromJson(Map<String, dynamic> json) {
    return AiTourModel(
      chatSeq: json['chatSeq'] as int,
      userUid: json['userUid'] as String,
      locationSeq: json['locationSeq'] as int,
      chatQuestion: json['chatQuestion'] as String,
      chatAnswer: json['chatAnswer'] as String,
    );
  }
}
