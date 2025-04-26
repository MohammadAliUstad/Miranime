import 'package:anitomo/data/fetch_top_anime.dart';

import '../data/fetch_anime_by_id.dart';
import '../model/anime_model.dart';
import 'anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  @override
  Future<List<Anime>> getTopAnime(int page) async {
    return await fetchTopAnime(page);
  }

  @override
  Future<Anime> getAnimeById(int malId) async {
    return await fetchAnimeById(malId);
  }
}