import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final ThemeData theme;

  const SectionTitle({super.key, required this.title, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}