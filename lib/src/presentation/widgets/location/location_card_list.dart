import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/presentation/widgets/location/location_card.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';

class LocationCardList extends StatelessWidget {
  final List<Location> locations;

  const LocationCardList({Key? key, required this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return const Center(
        child: Text(
          "No locations available",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Column(
  children: List.generate(locations.length, (index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: LocationCard(location: locations[index]),
    );
  }),
);
  }
}
