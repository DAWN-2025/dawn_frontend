class StampCard {
  final int eventId;
  final String eventName;
  final String eventNameEng;
  final String eventStampImg;
  bool? isVisited;

  StampCard({
    required this.eventId,
    required this.eventName,
    required this.eventNameEng,
    required this.eventStampImg,
    required this.isVisited,
  });

  // JSON 데이터를 StampCard 객체로 변환
factory StampCard.fromJson(Map<String, dynamic> json, {required bool isVisited}) {
  return StampCard(
    eventId: json['eventSeq'] ?? 0,
    eventName: json['eventName'] ?? 'Unknown',
    eventNameEng: json['eventNameEng'] ?? 'Unknown',
    eventStampImg: json['eventStampImg'] ?? '',
    isVisited: isVisited,  // 외부에서 받은 값을 사용
  );
}


  // JSON 리스트를 List<StampCard>로 변환
  static List<StampCard> fromJsonList(List<dynamic> jsonList, {required bool isVisited}) {
    return jsonList.map((json) => StampCard.fromJson(json, isVisited: isVisited)).toList();
  }
}
