import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/location_card_view_model.dart';
import 'location_card.dart';

class LocationCardList extends StatelessWidget {
  final List<LocationCardModel> locationCards;

  const LocationCardList({Key? key, required this.locationCards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: locationCards.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final viewModel = LocationCardViewModel(locationCard: locationCards[index]);
        return LocationCard(locationViewModel: viewModel);
      },
    );
  }
}
