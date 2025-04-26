import 'package:anitomo/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repository/anime_repository.dart';
import 'repository/anime_repository_impl.dart';
import 'viewmodel/anime_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AnimeRepository>(create: (context) => AnimeRepositoryImpl()),
        ChangeNotifierProvider<AnimeViewModel>(
          create:
              (context) => AnimeViewModel(
                Provider.of<AnimeRepository>(context, listen: false),
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
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      home: HomeScreen(),
    );
  }
}