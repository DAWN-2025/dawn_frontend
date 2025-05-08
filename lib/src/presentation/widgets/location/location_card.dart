import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class LocationCard extends StatelessWidget {
  final Location location;

  const LocationCard({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              // 이미지 배경
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.asset(
                  location.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 100,
                ),
              ),
              // 어두운 필터
              if (!location.visited)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              // Blur 효과
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 좌상단 방문 여부 아이콘
              Positioned(
                top: 8,
                left: 8,
                child: SvgPicture.asset(
                  location.visited
                      ? 'assets/icons/mail_close.svg'
                      : 'assets/icons/lock.svg',
                  width: 24,
                  height: 24,
                )
              ),
              Positioned(
                bottom: 10,
                left: 16,
                right: 16,
                child: Text(
                  location.name,
                  style: typography.AppTextStyle.bodyText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3), // 글자 그림자
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                      ),
                    ],
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
