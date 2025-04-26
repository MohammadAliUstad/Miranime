class Anime {
  final String title;
  final String imageUrl;
  final String largeImageUrl;
  final double score;
  final String url;
  final String synopsis;

  Anime({
    required this.title,
    required this.imageUrl,
    required this.largeImageUrl,
    required this.score,
    required this.url,
    required this.synopsis,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      title: json['title'] ?? '',
      imageUrl: json['images']['jpg']['image_url'] ?? '',
      largeImageUrl: json['images']['jpg']['large_image_url'] ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      url: json['url'] ?? '',
      synopsis: json['synopsis'] ?? '',
    );
  }
}