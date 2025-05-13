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

  factory StampCard.fromJson(Map<String, dynamic> json) {
    return StampCard(
      eventSeq: json['eventSeq'],
      eventName: json['eventName'],
      eventNameEng: json['eventNameEng'],
      eventStampImg: json['eventStampImg'],
    );
  }
}
