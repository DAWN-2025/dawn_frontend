import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;
import 'package:dawn_frontend/src/data/models/location_card_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/modals/no_visit_history_modal.dart';

class LocationCard extends StatelessWidget {
  final LocationCardModel locationCard;

  const LocationCard({Key? key, required this.locationCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        onTap: () => _handleCardTap(context),
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
                if (!locationCard.visited) _buildOverlay(), // 방문 안한 경우
                _buildBottomBlur(), // Blur 효과
                _buildVisitedIcon(), // 방문 여부 아이콘
                _buildLocationName(), // 장소 이름
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        locationCard.locationSimpleImage,
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

  Widget _buildVisitedIcon() {
    return Positioned(
      top: 8,
      left: 8,
      child: SvgPicture.asset(
        locationCard.visited
            ? 'assets/icons/mail_close.svg'
            : 'assets/icons/lock.svg',
        width: 24,
        height: 24,
        color: Colors.white,
      ),
    );
  }

  Widget _buildLocationName() {
    return Positioned(
      bottom: 10,
      left: 16,
      right: 16,
      child: Text(
        locationCard.name,
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

  void _handleCardTap(BuildContext context) {
    if (locationCard.visited) {
      // 방문한 경우 바로 이동
      context.push('/letter/${locationCard.id}');
    } else {
      // 미방문한 경우 모달 표시
      _showNoVisitHistoryModal(context);
    }
  }

  void _showNoVisitHistoryModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext modalContext) {
        return NoVisitHistoryModal(
          onGoToDetail: () {
            Navigator.of(modalContext).pop(); // 모달 닫기
            Future.microtask(
              () => GoRouter.of(
                context,
              ).push('/location-detail/${locationCard.id}'),
            );
          },
        );
      },
    );
  }

  // void _navigateToDetail(BuildContext context) {
  //   // 부모 context를 사용하여 경로 이동
  // if (context.mounted) {
  //   context.push('/location-detail/${locationCard.id}');
  // } else {
  //   GoRouter.of(context).push('/location-detail/${locationCard.id}');
  // }
  //}
}
