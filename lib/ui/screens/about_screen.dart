import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About Miranime',
          style: ts.titleLarge?.copyWith(color: cs.onSurface),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: cs.onSurface,
        ),
        backgroundColor: cs.surface,
        elevation: 0,
      ),
      backgroundColor: cs.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 100, color: cs.primary),
            const SizedBox(height: 16),
            Text(
              "Miranime",
              style: ts.headlineMedium?.copyWith(
                color: cs.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "ミラニメ",
              style: ts.headlineSmall?.copyWith(
                color: cs.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Miranime brings you detailed anime info, episode listings, and more in a clean, distraction-free experience. Dive into the world of anime and track your favorites effortlessly.",
              textAlign: TextAlign.center,
              style: ts.bodyMedium?.copyWith(color: cs.onSurface),
            ),
            const SizedBox(height: 24),
            Text(
              "Made by Yugen Tech",
              style: ts.bodyLarge?.copyWith(color: cs.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              "Version 1.0.0",
              style: ts.bodySmall?.copyWith(color: cs.onSurface),
            ),
            const SizedBox(height: 32),

            _ContactButton(
              icon: Icons.email,
              label: 'Contact Developer',
              onTap: () {
                final emailUri = Uri.parse("mailto:your_email@example.com");
                launchUrl(emailUri);
              },
            ),
            const SizedBox(height: 12),
            _ContactButton(
              icon: Icons.open_in_browser,
              label: 'Visit GitHub',
              onTap: () {
                final url = Uri.parse("https://github.com/yourgithub");
                launchUrl(url);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: cs.primary),
      label: Text(label, style: TextStyle(color: cs.primary)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: cs.primary),
      ),
    );
  }
}
