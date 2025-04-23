import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/anime_viewmodel.dart';
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
    // Trigger the initial API call
    Future.microtask(() {
      if (mounted) {
        Provider.of<AnimeViewModel>(
            context,
            listen: false
        ).loadTopAnime();
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

          return ListView.builder(
            itemCount: viewModel.animeList.length + (viewModel.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == viewModel.animeList.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final anime = viewModel.animeList[index];
              return ListTile(
                leading: Image.network(
                  anime.imageUrl,
                  width: 50,
                  height: 70,
                  fit: BoxFit.cover,
                ),
                title: Text(anime.title),
                subtitle: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow),
                    const SizedBox(width: 4),
                    Text('${anime.score}'),
                  ],
                ),
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