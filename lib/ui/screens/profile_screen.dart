import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Otaku!',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: Provider.of<ThemeProvider>(context).isDarkMode,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
                },
              ),
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('App Info'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'AniTomo',
                  applicationVersion: 'v1.0.0',
                  applicationLegalese: '© 2025 Muhammad',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}