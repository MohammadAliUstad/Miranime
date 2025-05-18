import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/anime_model.dart';
import '../../viewmodel/anime_viewmodel.dart';

class DetailsScreen extends StatefulWidget {
  final int malId;
  const DetailsScreen({super.key, required this.malId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _episodesFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch episodes once when widget is inserted in tree
    if (!_episodesFetched) {
      context.read<AnimeViewModel>().getEpisodeById(widget.malId);
      _episodesFetched = true;
    }
  }

  static const horizontalPadding = 16.0;
  static const verticalSectionSpacing = 24.0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;

    return Scaffold(
      // Remove appBar here to avoid duplication
      body: FutureBuilder<Anime?>(
        future: context.read<AnimeViewModel>().getAnimeById(widget.malId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Unable to load details.'));
          }
          final anime = snapshot.data!;

          return CustomScrollView(
            slivers: [
              // Pinned SliverAppBar with flexibleSpace for header image
              SliverAppBar(
                pinned: true,
                expandedHeight: 280,
                backgroundColor: cs.surface,
                leading: const BackButton(),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    child: Image.network(
                      anime.largeImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  titlePadding: EdgeInsets.zero, // No title to avoid scrim overlay
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: verticalSectionSpacing),

                      Center(
                        child: Text(
                          anime.title,
                          style: ts.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: cs.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Center(
                        child: Text(
                          anime.titleJapanese,
                          style: ts.bodyMedium,
                        ),
                      ),

                      const SizedBox(height: verticalSectionSpacing),

                      _InfoChipsRow(anime: anime),

                      const SizedBox(height: verticalSectionSpacing),

                      _Section(title: 'Synopsis', child: Text(anime.synopsis, style: ts.bodyMedium)),

                      _Section(
                        title: 'Genres',
                        child: Wrap(
                          spacing: 8,
                          children: anime.genres.map((g) => Chip(label: Text(g))).toList(),
                        ),
                      ),

                      _Section(
                        title: 'Details',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _DetailItem(label: 'Status', value: anime.airingStatus),
                            _DetailItem(label: 'Episodes', value: anime.episodeCount),
                            _DetailItem(label: 'Aired', value: anime.airingDateRange),
                            _DetailItem(label: 'Rating', value: anime.rating),
                            _DetailItem(label: 'Duration', value: anime.duration),
                            _DetailItem(label: 'Season & Year', value: '${anime.season} ${anime.year}'),
                          ],
                        ),
                      ),

                      _Section(
                        title: 'Producers',
                        child: Wrap(
                          spacing: 8,
                          children: anime.producers.map((p) => Chip(label: Text(p))).toList(),
                        ),
                      ),

                      if (anime.background.isNotEmpty)
                        _Section(title: 'Background', child: Text(anime.background, style: ts.bodySmall)),

                      const SizedBox(height: verticalSectionSpacing / 2),

                      if (anime.trailerUrl.isNotEmpty)
                        _ActionButton(label: 'Watch Trailer', icon: Icons.play_circle, url: anime.trailerUrl),

                      _ActionButton(label: 'More Info', icon: Icons.open_in_new, url: anime.url),

                      const SizedBox(height: verticalSectionSpacing),

                      EpisodeListSection(malId: widget.malId),

                      const SizedBox(height: verticalSectionSpacing),
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

class _InfoChipsRow extends StatelessWidget {
  final Anime anime;
  const _InfoChipsRow({required this.anime});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        _Capsule(label: '${anime.score}', color: cs.primary),
        _Capsule(label: 'Rank ${anime.rank}', color: cs.secondary),
        _Capsule(label: 'Pop ${anime.popularity}', color: cs.tertiary),
      ],
    );
  }
}

class _Capsule extends StatelessWidget {
  final String label;
  final Color color;
  const _Capsule({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: ts.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const _DetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: ts.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          Expanded(child: Text(value, style: ts.bodyMedium)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;

  const _ActionButton({required this.label, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: ElevatedButton.icon(
          icon: Icon(icon),
          label: Text(label),
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          onPressed: () async {
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Could not open the link')),
              );
            }
          },
        ),
      ),
    );
  }
}

class EpisodeListSection extends StatelessWidget {
  final int malId;
  const EpisodeListSection({super.key, required this.malId});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
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
                style: ts.bodyMedium?.copyWith(color: Colors.redAccent),
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
                style: ts.bodyMedium,
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Episodes',
              style: ts.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      '${index + 1}: ${episode.title}',
                      style: ts.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_circle, color: Colors.blueAccent),
                      tooltip: 'Watch Episode',
                      onPressed: () async {
                        final uri = Uri.parse(episode.url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Could not open the episode link')),
                          );
                        }
                      },
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
