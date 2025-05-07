import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedCarouselSkeleton extends StatelessWidget {
  const FeaturedCarouselSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    // Use softer, darker grays for a calmer shimmer
    final baseColor = Colors.grey.shade800;
    final highlightColor = Colors.grey.shade700;

    return SizedBox(
      height: 425,
      child: Center(
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          direction: ShimmerDirection.ltr,
          period: const Duration(milliseconds: 1800),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 425,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                // Background
                Container(
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                // Gradient overlay (dark tone)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 250,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // Title bar
                Positioned(
                  left: 16,
                  right: 100,
                  bottom: 20,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
