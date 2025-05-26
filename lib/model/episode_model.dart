class Episode {
  final int malId;
  final String title;
  final double? score;
  final bool isFiller;

  Episode({
    required this.malId,
    required this.title,
    required this.score,
    required this.isFiller,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      malId: json['mal_id'],
      title: json['title'] ?? '',
      score: (json['score'] as num?)?.toDouble(),
      isFiller: json['filler'] ?? false,
    );
  }
}