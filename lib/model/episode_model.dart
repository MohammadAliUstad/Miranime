class Episode {
  final int malId;
  final String title;
  final String titleJapanese;
  final String aired;
  final double? score;
  final String url;
  final bool isFiller;
  final bool isRecap;

  Episode({
    required this.malId,
    required this.title,
    required this.titleJapanese,
    required this.aired,
    required this.score,
    required this.url,
    required this.isFiller,
    required this.isRecap,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      malId: json['mal_id'],
      title: json['title'] ?? '',
      titleJapanese: json['title_japanese'] ?? '',
      aired: json['aired'] ?? '',
      score: (json['score'] as num?)?.toDouble(),
      url: json['url'] ?? '',
      isFiller: json['filler'] ?? false,
      isRecap: json['recap'] ?? false,
    );
  }
}
