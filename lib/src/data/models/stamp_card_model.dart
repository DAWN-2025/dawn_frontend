class StampCard {
  final int eventSeq;
  final String eventName;
  final String eventNameEng;
  final String eventStampImg;

  StampCard({
    required this.eventSeq,
    required this.eventName,
    required this.eventNameEng,
    required this.eventStampImg,
  });

  // JSON 데이터를 StampCard 객체로 변환
  factory StampCard.fromJson(Map<String, dynamic> json) {
    return StampCard(
      eventSeq: json['eventSeq'] ?? 0,
      eventName: json['eventName'] ?? 'Unknown',
      eventNameEng: json['eventNameEng'] ?? 'Unknown',
      eventStampImg: json['eventStampImg'] ?? '',
    );
  }

  @override
  String toString() {
    return 'StampCard(eventSeq: $eventSeq, eventName: $eventName, eventNameEng: $eventNameEng, eventStampImg: $eventStampImg)';
  }
}
