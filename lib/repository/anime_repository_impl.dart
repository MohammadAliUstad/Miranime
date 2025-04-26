import 'package:anitomo/data/fetchtopanime.dart';

import '../data/fetchanimebyid.dart';
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