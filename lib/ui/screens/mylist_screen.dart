import 'package:flutter/material.dart';

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      backgroundColor: color.surface,
      appBar: AppBar(
        title: Text(
          'My List',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: color.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: color.surface,
      ),
      body: Center(
        child: Text(
          'You haven\'t added any anime yet!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}