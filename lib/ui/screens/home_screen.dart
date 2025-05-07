import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../viewmodel/anime_viewmodel.dart';
import '../components/featured_carousel.dart';
import '../components/genre_section.dart';
import '../loading_skeletons/featured_carousel_skeleton.dart';
import '../loading_skeletons/genre_section_skeleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

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
    vm.fetchGenresSequentially();
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
              final q = _searchController.text.trim();
              if (q.isNotEmpty) {
                context.read<AnimeViewModel>().getAnimeBySearch(q);
              }
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
                  ? FeaturedCarouselSkeleton()
                  : FeaturedCarousel(viewModel: vm),
              const SizedBox(height: 24),

              ..._genres.map((g) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child:
                      vm.isLoadingForHomeScreen
                          ? GenreSectionSkeleton(genreName: g['name'])
                          : GenreSection(
                            genreId: g['id'],
                            genreName: g['name'],
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

  Widget _buildSectionTitle(String t, ThemeData th) {
    return Text(
      t,
      style: th.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: th.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildShimmerEffect({required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}