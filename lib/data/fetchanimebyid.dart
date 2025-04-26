import '../model/anime_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Anime> fetchAnimeById(int malId) async {
  final response = await http.get(
    Uri.parse('https://api.jikan.moe/v4/anime/$malId'),
  );

  if (response.statusCode == 200) {
    final dynamic animeData = json.decode(response.body)['data'];
    return Anime.fromJson(animeData);
  } else {
    throw Exception('Failed to load anime details');
  }
}