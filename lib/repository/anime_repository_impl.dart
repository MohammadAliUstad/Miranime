import 'package:anitomo/data/fetchtopanime.dart';
import '../model/anime_model.dart';
import 'anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  @override
  Future<List<Anime>> getTopAnime(int page) async {
    return await fetchTopAnime(page);
  }
}