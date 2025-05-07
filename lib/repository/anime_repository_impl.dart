import '../data/anime_api_service.dart';
import '../model/anime_model.dart';
import 'anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final ApiService apiService;

  AnimeRepositoryImpl({required this.apiService});

  @override
  Future<List<Anime>> getTopAnime({int page = 1}) async {
    return await apiService.fetchTopAnime(page: page);
  }

  @override
  Future<List<Anime>> getAnimeBySearch(String query) async {
    return await apiService.fetchAnimeBySearch(query);
  }

  @override
  Future<List<Anime>> getAnimeByGenre(int genreId) async {
    return await apiService.fetchAnimeByGenre(genreId);
  }

  @override
  Future<Anime> getAnimeById(int malId) async {
    return await apiService.fetchAnimeById(malId);
  }
}