import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/anime_viewmodel.dart';

class EpisodeListSection extends StatelessWidget {
  final int malId;
  const EpisodeListSection({super.key, required this.malId});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Consumer<AnimeViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoadingEpisodesFor(malId)) {
          return const Center(child: CircularProgressIndicator());
        }

        final episodeError = vm.getEpisodeErrorFor(malId);
        if (episodeError != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                episodeError,
                style: ts.bodyMedium?.copyWith(color: cs.error),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final episodes = vm.getEpisodesFor(malId);
        if (episodes.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'No episodes available.',
                style: ts.bodyMedium?.copyWith(color: cs.onSurface),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Episodes',
              style: ts.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: episodes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final episode = episodes[index];
                return Card(
                  color: cs.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.zero,
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      '${index + 1}: ${episode.title}',
                      style: ts.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.play_circle, color: cs.primary),
                      tooltip: 'Watch Episode',
                      onPressed: () {}
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}