import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/anime_model.dart';
import '../../viewmodel/anime_viewmodel.dart';

class DetailsScreen extends StatelessWidget {
  final int malId;

  const DetailsScreen({super.key, required this.malId});

  @override
  Widget build(BuildContext context) {
    final animeViewModel = Provider.of<AnimeViewModel>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: FutureBuilder<Anime?>(
        future: animeViewModel.getAnimeById(malId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load anime details.'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Anime not found.'));
          }

          final anime = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'anime_${anime.malID}', // Optional for hero animations
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      child: Image.network(
                        anime.largeImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                backgroundColor: colorScheme.surface,
                surfaceTintColor: colorScheme.surfaceTint,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Title
                      Center(
                        child: Text(
                          anime.title,
                          textAlign: TextAlign.center,
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Score
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: colorScheme.onPrimaryContainer, size: 20),
                              const SizedBox(width: 6),
                              Text(
                                anime.score.toString(),
                                style: TextStyle(
                                  color: colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Synopsis
                      _InfoSection(
                        title: 'Synopsis',
                        child: Text(
                          anime.synopsis,
                          style: textTheme.bodyMedium?.copyWith(height: 1.5),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Genres
                      _InfoSection(
                        title: 'Genres',
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: anime.genres.map((genre) {
                            return Chip(
                              label: Text(genre),
                              backgroundColor: colorScheme.secondaryContainer,
                              labelStyle: TextStyle(color: colorScheme.onSecondaryContainer),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Button
                      Center(
                        child: FilledButton.icon(
                          onPressed: () => launchUrl(Uri.parse(anime.url)),
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('View More Info'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _InfoSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Material(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ],
    );
  }
}
