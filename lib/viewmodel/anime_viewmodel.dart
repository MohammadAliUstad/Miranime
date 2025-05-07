import 'package:flutter/material.dart';
import '../model/anime_model.dart';
import '../repository/anime_repository.dart';

class AnimeViewModel extends ChangeNotifier {
  final AnimeRepository _repository;

  AnimeViewModel({required AnimeRepository repository}) : _repository = repository;

  final List<Anime> _topAnimeList = [];
  final List<Anime> _searchResultsList = [];
  final Map<int, List<Anime>> _genreAnimeMap = {};

  String? _errorMessage;
  bool _isTopLoading = false;
  bool _isSearchLoading = false;
  bool _isGenresLoading = false;

  final Set<int> _loadingGenres = {};
  int _currentPage = 1;
  bool _hasMore = true;

  List<Anime> get topAnimeList => _topAnimeList;
  List<Anime> get searchResultsList => _searchResultsList;
  Map<int, List<Anime>> get genreAnimeMap => _genreAnimeMap;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  bool get isTopLoading => _isTopLoading;
  bool get isSearchLoading => _isSearchLoading;
  bool get isGenresLoading => _isGenresLoading;

  // Unified loading for home screen
  bool get isLoadingForHomeScreen => _isTopLoading || _isGenresLoading;

  // Dummy genres
  final List<Map<String, dynamic>> _genres = [
    {"id": 1, "name": "Action"},
    {"id": 4, "name": "Comedy"},
    {"id": 30, "name": "Sports"},
    {"id": 22, "name": "Romance"},
  ];

  Future<void> getTopAnime() async {
    if (_isTopLoading || !_hasMore) return;

    _isTopLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedAnime = await _repository.getTopAnime(page: _currentPage);
      _topAnimeList.addAll(fetchedAnime);
      _hasMore = fetchedAnime.length == 25;
      _currentPage++;
    } catch (e) {
      _errorMessage = "Error fetching top anime: $e";
    } finally {
      _isTopLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshTopAnime() async {
    _topAnimeList.clear();
    _currentPage = 1;
    _hasMore = true;
    await getTopAnime();
  }

  Future<void> getAnimeBySearch(String query) async {
    _isSearchLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final searchResults = await _repository.getAnimeBySearch(query);
      _searchResultsList.clear();
      _searchResultsList.addAll(searchResults);
    } catch (e) {
      _errorMessage = "Error searching for anime: $e";
    } finally {
      _isSearchLoading = false;
      notifyListeners();
    }
  }

  void clearSearchResults() {
    _searchResultsList.clear();
    notifyListeners();
  }

  Future<void> getAnimeByGenre(List<int> genreIds) async {
    for (var genreId in genreIds) {
      if (_genreAnimeMap.containsKey(genreId) || _loadingGenres.contains(genreId)) continue;

      _loadingGenres.add(genreId);
      _errorMessage = null;
      notifyListeners();

      try {
        await Future.delayed(const Duration(seconds: 1));
        final genreAnime = await _repository.getAnimeByGenre(genreId);
        _genreAnimeMap[genreId] = genreAnime;
      } catch (e) {
        _errorMessage = "Error fetching genre $genreId: $e";
      } finally {
        _loadingGenres.remove(genreId);
        notifyListeners();
      }
    }
  }

  bool isGenreLoading(int genreId) => _loadingGenres.contains(genreId);

  Future<Anime?> getAnimeById(int malId) async {
    try {
      return await _repository.getAnimeById(malId);
    } catch (e) {
      return null;
    }
  }

  Future<void> fetchGenresSequentially() async {
    _isGenresLoading = true;
    notifyListeners();

    for (var genre in _genres) {
      await Future.delayed(const Duration(seconds: 1));
      await getAnimeByGenre([genre['id']]);
    }

    _isGenresLoading = false;
    notifyListeners();
  }
}