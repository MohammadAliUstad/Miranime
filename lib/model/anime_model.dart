class Anime {
  final int malID;
  final String title;
  final String largeImageUrl;
  final double score;
  final String url;
  final String synopsis;
  final String titleJapanese;
  final String airingStatus;
  final String airingDateRange;
  final String episodeCount;
  final String rating;
  final String background;
  final List<String> genres;
  final String trailerUrl;
  final List<String> producers;
  final String duration;
  final String season;
  final int year;
  final int popularity;
  final int rank;

  Anime({
    required this.malID,
    required this.title,
    required this.largeImageUrl,
    required this.score,
    required this.url,
    required this.synopsis,
    required this.titleJapanese,
    required this.airingStatus,
    required this.airingDateRange,
    required this.episodeCount,
    required this.rating,
    required this.background,
    required this.genres,
    required this.trailerUrl,
    required this.producers,
    required this.duration,
    required this.season,
    required this.year,
    required this.popularity,
    required this.rank,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      malID: json['mal_id'],
      title: json['title'] ?? '',
      largeImageUrl: json['images']['jpg']['large_image_url'] ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      url: json['url'] ?? '',
      synopsis: json['synopsis'] ?? '',
      titleJapanese: json['title_japanese'] ?? '',
      airingStatus: json['status'] ?? '',
      airingDateRange: json['aired']['string'] ?? '',
      episodeCount: json['episodes'].toString(),
      rating: json['rating'] ?? '',
      background: json['background'] ?? '',
      genres: List<String>.from(
        json['genres']?.map((genre) => genre['name']) ?? [],
      ),
      trailerUrl: json['trailer']?['url'] ?? '',
      producers: List<String>.from(
        json['producers']?.map((producer) => producer['name']) ?? [],
      ),
      duration: json['duration'] ?? '',
      season: json['season'] ?? '',
      year: json['year'] ?? 0,
      popularity: json['popularity'] ?? 0,
      rank: json['rank'] ?? 0,
    );
  }
}