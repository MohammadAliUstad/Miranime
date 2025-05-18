class Anime {
  final int malID;
  final String title;
  final String imageUrl;
  final String largeImageUrl;
  final double score;
  final String url;
  final String synopsis;
  final String titleEnglish;
  final String titleJapanese;
  final List<String> titleSynonyms;
  final String airingStatus;
  final String airingDateRange;
  final String episodeCount;
  final String broadcastTime;
  final String rating;
  final String background;
  final List<String> genres;
  final String trailerUrl;
  final String trailerImageUrl;
  final List<String> producers;
  final String source;
  final String type;
  final String season;
  final int year;
  final int popularity;
  final int rank;
  final int members;
  final int favorites;
  final String duration;
  final String trailerYoutubeId;

  Anime({
    required this.malID,
    required this.title,
    required this.imageUrl,
    required this.largeImageUrl,
    required this.score,
    required this.url,
    required this.synopsis,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.titleSynonyms,
    required this.airingStatus,
    required this.airingDateRange,
    required this.episodeCount,
    required this.broadcastTime,
    required this.rating,
    required this.background,
    required this.genres,
    required this.trailerUrl,
    required this.trailerImageUrl,
    required this.producers,
    required this.source,
    required this.type,
    required this.season,
    required this.year,
    required this.popularity,
    required this.rank,
    required this.members,
    required this.favorites,
    required this.duration,
    required this.trailerYoutubeId,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      malID: json['mal_id'],
      title: json['title'] ?? '',
      imageUrl: json['images']['jpg']['image_url'] ?? '',
      largeImageUrl: json['images']['jpg']['large_image_url'] ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      url: json['url'] ?? '',
      synopsis: json['synopsis'] ?? '',
      titleEnglish: json['title_english'] ?? '',
      titleJapanese: json['title_japanese'] ?? '',
      titleSynonyms: List<String>.from(json['title_synonyms'] ?? []),
      airingStatus: json['status'] ?? '',
      airingDateRange: json['aired']['string'] ?? '',
      episodeCount: json['episodes'].toString(),
      broadcastTime: json['broadcast']?['string'] ?? '',
      rating: json['rating'] ?? '',
      background: json['background'] ?? '',
      genres: List<String>.from(
        json['genres']?.map((genre) => genre['name']) ?? [],
      ),
      trailerUrl: json['trailer']?['url'] ?? '',
      trailerImageUrl: json['trailer']?['images']?['image_url'] ?? '',
      producers: List<String>.from(
        json['producers']?.map((producer) => producer['name']) ?? [],
      ),
      source: json['source'] ?? '',
      type: json['type'] ?? '',
      season: json['season'] ?? '',
      year: json['year'] ?? 0,
      popularity: json['popularity'] ?? 0,
      rank: json['rank'] ?? 0,
      members: json['members'] ?? 0,
      favorites: json['favorites'] ?? 0,
      duration: json['duration'] ?? '',
      trailerYoutubeId: json['trailer']?['youtube_id'] ?? '',
    );
  }
}