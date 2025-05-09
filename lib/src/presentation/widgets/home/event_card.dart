import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/typography.dart';
import '../tag/tag_chip_small.dart';

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final List<String> tags;

  const EventCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195,
      width: 175,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withAlpha(51),
        border: Border.all(color: Colors.white.withAlpha(128), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            // 이미지
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: 152,
                  height: 120,
                  // 기존보다 줄임
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 6),
            // 태그
            Wrap(
              spacing: 2,
              runSpacing: 2,
              alignment: WrapAlignment.start,
              children: tags.map((tag) => TagChipSmall(label: tag)).toList(),
            ),
            const SizedBox(height: 6),
            // 타이틀
            Center(
              child: Text(
                title,
                style: AppTextStyle.heading3.copyWith(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
