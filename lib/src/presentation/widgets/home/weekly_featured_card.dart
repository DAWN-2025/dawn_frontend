import 'package:dawn_frontend/src/core/theme/typography.dart';
import 'package:dawn_frontend/src/presentation/widgets/tag/tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WeeklyFeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final List<String> tags;
  final VoidCallback? onTap;

  const WeeklyFeaturedCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.tags,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white.withAlpha(51),
          border: Border.all(color: Colors.white.withAlpha(128), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 110,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // 태그
              Wrap(
                spacing: 5,
                runSpacing: 5,
                alignment: WrapAlignment.start,
                children: tags.map((tag) => TagChip(label: tag)).toList(),
              ),
              // 제목
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: AppTextStyle.heading3.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
