import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final String url;

  const DetailsScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anime Details')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                launchUrl(Uri.parse(url));
              },
              child: Text('View More Info'),
            ),
          ],
        ),
      ),
    );
  }
}