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
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<AnimeViewModel>(context, listen: false).loadTopAnime();
      }
    });
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
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: viewModel.animeList.length + (viewModel.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == viewModel.animeList.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final anime = viewModel.animeList[index];
              return AnimeCard(
                title: anime.title,
                largeImageUrl: anime.largeImageUrl,
                score: anime.score,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(url: anime.url),
                    ),
                  );
                },
              );

            },
          );
        },
      ),
      floatingActionButton: Consumer<AnimeViewModel>(
        builder: (context, viewModel, child) {
          return viewModel.hasMore
              ? FloatingActionButton(
                onPressed: viewModel.loadTopAnime,
                child: const Icon(Icons.arrow_downward),
              )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
