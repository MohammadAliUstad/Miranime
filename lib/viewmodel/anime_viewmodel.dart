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
    final genreFetchFutures = <Future<void>>[];

    for (var genreId in genreIds) {
      if (_genreAnimeMap.containsKey(genreId) || _loadingGenres.contains(genreId)) continue;

      _loadingGenres.add(genreId);
      _errorMessage = null;
      notifyListeners();

      genreFetchFutures.add(_repository.getAnimeByGenre(genreId).then((genreAnime) {
        _genreAnimeMap[genreId] = genreAnime;
        notifyListeners(); // Notify listeners immediately after genre data is fetched
      }).catchError((e) {
        _errorMessage = "Error fetching genre $genreId: $e";
        notifyListeners(); // Notify listeners even on error
      }).whenComplete(() {
        _loadingGenres.remove(genreId);
        notifyListeners();
      }));
    }

    // Wait for all genre fetch tasks to complete concurrently
    await Future.wait(genreFetchFutures);
  }

  bool isGenreLoading(int genreId) => _loadingGenres.contains(genreId);

  Future<Anime?> getAnimeById(int malId) async {
    try {
      return await _repository.getAnimeById(malId);
    } catch (e) {
      return null;
    }
  }

  // Fetch genres concurrently without delay
  Future<void> fetchGenresConcurrently() async {
    _isGenresLoading = true;
    notifyListeners();

    final genreIds = _genres.map<int>((genre) => genre['id'] as int).toList();

    // First batch: first 2 genres
    await getAnimeByGenre(genreIds.sublist(0, 2));

    // Wait 1 second (to respect API rate limit)
    await Future.delayed(const Duration(seconds: 1));

    // Second batch: remaining genres
    await getAnimeByGenre(genreIds.sublist(2));

    _isGenresLoading = false;
    notifyListeners();
  }
}
