import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/anime_viewmodel.dart';
import '../components/anime_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  void _startSearch() {
    final trimmed = _controller.text.trim();
    if (trimmed.isNotEmpty) {
      setState(() {
        _query = trimmed;
      });
      context.read<AnimeViewModel>().getAnimeBySearch(trimmed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AnimeViewModel>();
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          onSubmitted: (_) => _startSearch(),
          decoration: const InputDecoration(
            hintText: 'Search anime...',
            border: InputBorder.none,
          ),
          autofocus: true,
          textInputAction: TextInputAction.search,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _startSearch,
          ),
        ],
      ),
      body: vm.isSearchLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.searchResultsList.isEmpty && _query.isNotEmpty
          ? const Center(child: Text("No results found."))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: vm.searchResultsList.length,
        itemBuilder: (context, index) {
          final anime = vm.searchResultsList[index];
          return AnimeCard(anime: anime);
        },
      ),
    );
  }
}
