import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/anime_viewmodel.dart';
import '../components/featured_carousel.dart';
import '../components/genre_section.dart';
import '../loading_skeletons/featured_carousel_skeleton.dart';
import '../loading_skeletons/genre_section_skeleton.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _genres = [
    {"id": 1, "name": "Action"},
    {"id": 4, "name": "Comedy"},
    {"id": 30, "name": "Sports"},
    {"id": 22, "name": "Romance"},
  ];

  @override
  void initState() {
    super.initState();
    final vm = context.read<AnimeViewModel>();
    vm.getTopAnime();
    vm.fetchGenresConcurrently();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      backgroundColor: color.surface,
      appBar: AppBar(
        title: Text(
          'Miranime',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: color.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: color.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: color.onSurface,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<AnimeViewModel>(
        builder: (context, vm, _) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            physics: const BouncingScrollPhysics(),
            children: [
              // Featured Carousel or Skeleton
              _buildSectionTitle("Featured Anime", theme),
              const SizedBox(height: 12),
              vm.isLoadingForHomeScreen
                  ? const FeaturedCarouselSkeleton()
                  : FeaturedCarousel(viewModel: vm),
              const SizedBox(height: 24),

              // Genre Sections or Skeletons
              ..._genres.map((g) {
                final genreId = g['id'] as int;
                final genreName = g['name'] as String;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: vm.isGenreLoading(genreId)
                      ? GenreSectionSkeleton(genreName: genreName)
                      : GenreSection(
                    genreId: genreId,
                    genreName: genreName,
                    viewModel: vm,
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}
