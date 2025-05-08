import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'location_card.dart';

class LocationCardList extends StatelessWidget {
  final List<Location> locations;

  const LocationCardList({Key? key, required this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return const Center(
        child: Text("No locations available", style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: locations.length,
      itemBuilder: (context, index) {
        return LocationCard(location: locations[index]);
      },
    );
  }
}
