import 'package:flutter/material.dart';
import '../model/anime_model.dart';
import '../repository/anime_repository.dart';

class AnimeViewModel extends ChangeNotifier {
  final AnimeRepository _repository;

  AnimeViewModel(this._repository);

  final List<Anime> _animeList = [];

  List<Anime> get animeList => _animeList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int _currentPage = 1;
  bool _hasMore = true;

  bool get hasMore => _hasMore;

  Future<void> loadTopAnime() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final fetchedAnime = await _repository.getTopAnime(_currentPage);
      _animeList.addAll(fetchedAnime);
      _hasMore = fetchedAnime.length == 25;
      _currentPage++;
    } catch (e) {
      debugPrint("Error fetching anime: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}