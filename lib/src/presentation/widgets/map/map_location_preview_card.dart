import 'dart:ui';
import 'package:dawn_frontend/src/presentation/widgets/common/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MapLocationPreviewCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int locationId;

  const MapLocationPreviewCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.locationId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop(); // 닫기
        context.push('/location-detail/$locationId'); // 상세 페이지 이동
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // 배경 이미지
            ImageLoader(
              imageUrl: imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),

            // Blur + Gradient 효과
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 텍스트 오버레이
            Positioned(
              bottom: 12,
              left: 24,
              right: 24,
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 4,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
