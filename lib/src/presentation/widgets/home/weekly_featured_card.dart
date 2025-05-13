import 'package:dawn_frontend/src/core/theme/typography.dart';
import 'package:dawn_frontend/src/presentation/widgets/tag/tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WeeklyFeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final List<String> tags;

  const WeeklyFeaturedCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      //margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withAlpha(51),
        border: Border.all(color: Colors.white.withAlpha(128), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 위-아래 간격 최대화
          crossAxisAlignment: CrossAxisAlignment.start, // 태그는 왼쪽 정렬
          children: [
            // 1. 이미지 (중앙 정렬)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  //300
                  height: 110,
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 4),
            // 2. 태그 (왼쪽 정렬)
            Wrap(
              spacing: 5,
              runSpacing: 5,
              alignment: WrapAlignment.start,
              children: tags.map((tag) => TagChip(label: tag)).toList(),
            ),

            // 3. 제목 (하단 중앙 정렬 + 약간 위 여백)
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
    );
  }
}
