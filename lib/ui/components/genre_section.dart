import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../viewmodel/anime_viewmodel.dart';
import '../screens/details_screen.dart';

class GenreSection extends StatelessWidget {
  final int genreId;
  final String genreName;
  final AnimeViewModel viewModel;

  const GenreSection({
    super.key,
    required this.genreId,
    required this.genreName,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final list = viewModel.genreAnimeMap[genreId] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          genreName,
          style: tt.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 8),

        if (viewModel.isGenreLoading(genreId))
          const Center(child: CircularProgressIndicator())
        else if (list.isEmpty)
          Text("No anime found.", style: TextStyle(color: cs.onSurface))
        else
          SizedBox(
            height: 230,
            child: AnimationLimiter(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length.clamp(0, 8),
                itemBuilder: (context, i) {
                  final anime = list[i];
                  return AnimationConfiguration.staggeredList(
                    position: i,
                    duration: const Duration(milliseconds: 375),

                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        DetailsScreen(malId: anime.malID),
                              ),
                            );
                          },
                          child: Container(
                            width: 140,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 140,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(200),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                                        child: Image.network(
                                          anime.largeImageUrl,
                                          width: 140,
                                          height: 230,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high,
                                          loadingBuilder: (context, child, loadingProgress) => child,
                                          errorBuilder: (_, __, ___) => const Center(
                                            child: Icon(Icons.broken_image),
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),

                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    height: 200,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withAlpha(200),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    left: 8,
                                    right: 8,
                                    bottom: 8,
                                    child: Text(
                                      anime.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: tt.bodyMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        shadows: const [
                                          Shadow(
                                            color: Colors.black87,
                                            blurRadius: 4,
                                            offset: Offset(0.5, 0.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}