class KeywordDTO {
  final String keyword;
  final String keywordEng;

  KeywordDTO({
    required this.keyword,
    required this.keywordEng,
  });

  factory KeywordDTO.fromJson(Map<String, dynamic> json) {
    return KeywordDTO(
      keyword: json['keyword'] ?? '',
      keywordEng: json['keywordEng'] ?? '',
    );
  }
}
