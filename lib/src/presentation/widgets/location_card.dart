import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;
import 'package:dawn_frontend/src/presentation/view_models/location_card_view_model.dart';

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
                _buildImage(), // 이미지 배경
                if (!locationViewModel.locationCard!.visited) _buildOverlay(), // 방문 안한 경우
                _buildBottomBlur(), // Blur 효과
                _buildVisitedIcon(locationViewModel.locationCard!.visited), // 방문 여부 아이콘
                _buildLocationName(), // 장소 이름
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    print(
      "Navigating to location: ${locationViewModel.locationCard!.id} - ${locationViewModel.locationCard!.name}",
    );
    context.push('/location-detail/${locationViewModel.locationCard!.id}');
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        locationViewModel.locationCard!.locationImage,
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

  Widget _buildVisitedIcon(bool visited) {
    return Positioned(
      top: 8,
      left: 8,
      child: SvgPicture.asset(
        visited ? 'assets/icons/mail_close.svg' : 'assets/icons/lock.svg',
        width: 24,
        height: 24,
      ),
    );
  }

  Widget _buildLocationName() {
    return Positioned(
      bottom: 10,
      left: 16,
      right: 16,
      child: Text(
        locationViewModel.locationCard!.name,
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
