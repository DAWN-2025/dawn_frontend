import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/typography.dart';
import '../tag/tag_chip_small.dart';

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final List<String> tags;
  final VoidCallback? onTap;

  // 크기 조절 파라미터
  final double? width;
  final double? height;
  final double? fontSize;

  const EventCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.tags,
    this.onTap,
    this.width, // default 값은 아래에서 처리
    this.height,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? 175;
    final cardHeight = height ?? 195;
    final titleFontSize = fontSize ?? 11;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
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
                    width: cardWidth - 23,
                    height: cardHeight * 0.6,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
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
                    fontSize: titleFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
