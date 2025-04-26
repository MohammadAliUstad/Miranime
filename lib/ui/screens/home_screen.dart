import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/anime_viewmodel.dart';
import '../components/animecard.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<AnimeViewModel>(context, listen: false).loadTopAnime();
      }
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      final viewModel = Provider.of<AnimeViewModel>(context, listen: false);
      if (!viewModel.isLoading && viewModel.hasMore) {
        viewModel.loadTopAnime();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Anime')),
      body: Consumer<AnimeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.animeList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: viewModel.animeList.length,
            itemBuilder: (context, index) {
              final anime = viewModel.animeList[index];
              return AnimeCard(
                title: anime.title,
                largeImageUrl: anime.largeImageUrl,
                score: anime.score,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(malId: anime.malID),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}