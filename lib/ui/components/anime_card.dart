import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AnimeCard extends StatelessWidget {
  final String title;
  final String largeImageUrl;
  final double score;
  final VoidCallback onTap;

  const AnimeCard({
    super.key,
    required this.title,
    required this.largeImageUrl,
    required this.score,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    bool isTitleOverflowing = title.length > 20;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 1,
        margin: EdgeInsets.zero,
        color: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  largeImageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.error_outline));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    child: isTitleOverflowing
                        ? Marquee(
                      text: title,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      scrollAxis: Axis.horizontal,
                      blankSpace: 100.0,
                      velocity: 20.0,
                      pauseAfterRound: const Duration(seconds: 1),
                    )
                        : Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: colorScheme.primary, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        score.toString(),
                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}