import 'package:flutter/material.dart';
import 'location_card.dart';
import 'package:dawn_frontend/src/presentation/view_models/location_card_view_model.dart';

class LocationCardList extends StatelessWidget {
  final List<LocationCardViewModel> locationViewModels;

  const LocationCardList({Key? key, required this.locationViewModels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: locationViewModels.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return LocationCard(locationViewModel: locationViewModels[index]);
      },
    );
  }
}
