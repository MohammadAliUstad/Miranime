import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../viewmodel/anime_viewmodel.dart';
import '../screens/details_screen.dart';

class FeaturedCarousel extends StatelessWidget {
  final AnimeViewModel viewModel;

  const FeaturedCarousel({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (viewModel.isTopLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (viewModel.topAnimeList.isEmpty) {
      return Text(
        "No top anime found.",
        style: TextStyle(color: color.onSurface),
      );
    } else {
      return CarouselSlider.builder(
        itemCount: viewModel.topAnimeList.length.clamp(0, 5),
        itemBuilder: (context, index, _) {
          final anime = viewModel.topAnimeList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(malId: anime.malID),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(64),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      anime.largeImageUrl,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      loadingBuilder: (context, child, loadingProgress) {
                        return child;
                      },
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Center(child: Icon(Icons.broken_image)),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 250,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withAlpha(150),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 20,
                      child: Text(
                        anime.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 425,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          viewportFraction: 0.75,
          enableInfiniteScroll: true,
        ),
      );
    }
  }
}
