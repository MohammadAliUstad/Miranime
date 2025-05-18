import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/anime_model.dart';
import '../model/episode_model.dart';

class ApiService {
  static const String _baseUrl = 'https://api.jikan.moe/v4';

  Future<List<Anime>> fetchTopAnime({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/top/anime?page=$page'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> animeList = json.decode(response.body)['data'];
      return animeList.map((anime) => Anime.fromJson(anime)).toList();
    } else {
      throw Exception('Failed to load top anime');
    }
  }

  Future<List<Anime>> fetchAnimeBySearch(String query) async {
    final url = Uri.parse('$_baseUrl/anime?q=$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> animeList = json.decode(response.body)['data'];
      return animeList.map((anime) => Anime.fromJson(anime)).toList();
    } else {
      throw Exception('Failed to search anime');
    }
  }

  Future<List<Anime>> fetchAnimeByGenre(int genreId) async {
    final url = Uri.parse('$_baseUrl/anime?genres=$genreId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> animeList = json.decode(response.body)['data'];
      return animeList.map((anime) => Anime.fromJson(anime)).toList();
    } else {
      throw Exception('Failed to load anime by genre');
    }
  }

  Future<Anime> fetchAnimeById(int malId) async {
    final response = await http.get(Uri.parse('$_baseUrl/anime/$malId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> animeData = json.decode(response.body)['data'];
      return Anime.fromJson(animeData);
    } else {
      throw Exception('Failed to load anime details for ID $malId');
    }
  }

  Future<List<Episode>> fetchEpisodeById(int malId) async {
    final response = await http.get(Uri.parse('https://api.jikan.moe/v4/anime/$malId/episodes'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List).map((e) => Episode.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load episodes');
    }
  }
}