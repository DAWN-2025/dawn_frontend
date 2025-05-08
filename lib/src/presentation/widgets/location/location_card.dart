import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;
import 'package:dawn_frontend/src/presentation/view_models/location_card_view_model.dart';
import 'package:dawn_frontend/src/presentation/views/details/location_detail_screen.dart';
import 'package:go_router/go_router.dart';

class LocationCard extends StatelessWidget {
  final LocationCardViewModel locationViewModel;

  const LocationCard({Key? key, required this.locationViewModel})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        onTap: () => _navigateToDetail(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
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
                _buildImage(),
                if (!locationViewModel.visited) _buildOverlay(),
                _buildBottomBlur(),
                _buildVisitedIcon(),
                _buildLocationName(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 화면 전환 함수
  void _navigateToDetail(BuildContext context) {
    print(
      "Navigating to location: ${locationViewModel.locationId} - ${locationViewModel.name}",
    );
    context.push('/location-detail/${locationViewModel.locationId}');
  }

  /// 이미지 배경
  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Image.asset(
        locationViewModel.image,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 100,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey,
            child: const Icon(
              Icons.broken_image,
              size: 50,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  /// 방문하지 않은 경우 어두운 필터
  Widget _buildOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  /// Blur와 그라데이션
  Widget _buildBottomBlur() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.5), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 방문 여부 아이콘
  Widget _buildVisitedIcon() {
    return Positioned(
      top: 8,
      left: 8,
      child: SvgPicture.asset(
        locationViewModel.visited
            ? 'assets/icons/mail_close.svg'
            : 'assets/icons/lock.svg',
        width: 24,
        height: 24,
      ),
    );
  }

  /// 장소 이름
  Widget _buildLocationName() {
    return Positioned(
      bottom: 10,
      left: 16,
      right: 16,
      child: Text(
        locationViewModel.name,
        style: typography.AppTextStyle.bodyText.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
