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
      FocusScope.of(context).unfocus();
      setState(() {
        _query = trimmed;
      });
      context.read<AnimeViewModel>().getAnimeBySearch(trimmed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AnimeViewModel>();
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _controller,
            onSubmitted: (_) => _startSearch(),
            autofocus: true,
            textInputAction: TextInputAction.search,
            style: ts.bodyMedium?.copyWith(color: cs.onSurface),
            cursorColor: cs.primary,
            decoration: InputDecoration(
              hintText: 'Search anime...',
              hintStyle: ts.bodyMedium?.copyWith(color: cs.onSurface.withOpacity(0.5)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              isDense: true,
              suffixIcon: IconButton(
                icon: Icon(Icons.search, color: cs.primary),
                onPressed: _startSearch,
                tooltip: 'Search',
              ),
            ),
          ),
        ),
      ),



      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            vm.isSearchLoading
                ? const Center(child: CircularProgressIndicator())
                : _query.isNotEmpty && vm.searchResultsList.isEmpty
                ? Center(
                  child: Text(
                    'No results found.',
                    style: ts.bodyLarge?.copyWith(color: cs.onSurface),
                  ),
                )
                : ListView.separated(
                  itemCount: vm.searchResultsList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final anime = vm.searchResultsList[index];
                    return AnimeCard(anime: anime);
                  },
                ),
      ),
    );
  }
}
