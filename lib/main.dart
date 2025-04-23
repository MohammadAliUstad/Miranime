import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repository/anime_repository.dart';
import 'repository/anime_repository_impl.dart';
import 'viewmodel/anime_viewmodel.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    // Use a Provider to inject AnimeViewModel into the app
    MultiProvider(
      providers: [
        Provider<AnimeRepository>(create: (_) => AnimeRepositoryImpl()),
        ChangeNotifierProvider<AnimeViewModel>(create: (context) => AnimeViewModel(Provider.of<AnimeRepository>(context, listen: false))),
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