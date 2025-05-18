import 'package:miranime/model/episode_model.dart';

import '../model/anime_model.dart';

abstract class AnimeRepository {
  Future<List<Anime>> getTopAnime({int page = 1});

  Future<List<Anime>> getAnimeBySearch(String query);

  Future<List<Anime>> getAnimeByGenre(int genreId);

  Future<Anime> getAnimeById(int malId);

  Future<List<Episode>> getEpisodeById(int malId);
}