import 'package:flutter/material.dart';
import 'package:miranime/ui/screens/main_screen.dart';
import 'package:miranime/ui/theme/theme_provider.dart';
import 'package:miranime/ui/theme/themes.dart';
import 'package:provider/provider.dart';

import 'data/anime_api_service.dart';
import 'repository/anime_repository.dart';
import 'repository/anime_repository_impl.dart';
import 'viewmodel/anime_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        Provider<AnimeRepository>(
          create: (context) => AnimeRepositoryImpl(apiService: ApiService()),
        ),
        ChangeNotifierProvider<AnimeViewModel>(
          create:
              (context) => AnimeViewModel(
                repository: Provider.of<AnimeRepository>(
                  context,
                  listen: false,
                ),
              ),
        ),
      ],
      child: AnimeApp(),
    ),
  );
}

class AnimeApp extends StatelessWidget {
  const AnimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anime Info',
      theme: monochromeLightTheme,
      darkTheme: monochromeDarkTheme,
      themeMode: themeProvider.themeMode,
      home: const MainScreen(),
    );
  }
}