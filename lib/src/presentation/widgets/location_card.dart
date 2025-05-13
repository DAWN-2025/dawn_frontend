import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';

class LocationCard extends StatelessWidget {
  final LocationCardModel locationCardModel;

  const LocationCard({Key? key, required this.locationCardModel}) : super(key: key);

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
                if (!locationCardModel.visited) _buildOverlay(),
                _buildLocationName(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    context.push('/location-detail/${locationCardModel.id}');
  }

  Widget _buildImage() {
    return Image.network(
      locationCardModel.locationImage,
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
    );
  }

  Widget _buildOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.6),
      ),
    );
  }

  Widget _buildLocationName() {
    return Positioned(
      bottom: 10,
      left: 16,
      right: 16,
      child: Text(
        locationCardModel.name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
