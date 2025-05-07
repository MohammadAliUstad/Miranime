import 'package:anitomo/ui/screens/main_screen.dart';
import 'package:anitomo/ui/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/anime_api_service.dart';
import 'repository/anime_repository.dart';
import 'repository/anime_repository_impl.dart';
import 'viewmodel/anime_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anime Info',
      theme: monochromeLightTheme,
      darkTheme: monochromeDarkTheme,
      themeMode: ThemeMode.system,
      home: MainScreen(),
    );
  }
}