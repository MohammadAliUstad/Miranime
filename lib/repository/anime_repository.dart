import '../model/anime_model.dart';

abstract class AnimeRepository {
  Future<List<Anime>> getTopAnime(int page);
}