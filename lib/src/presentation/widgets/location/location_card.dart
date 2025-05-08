import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';

class LocationCard extends StatelessWidget {
  final Location location;

  const LocationCard({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Colors.blueAccent),
        title: Text(
          location.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(location.address),
        trailing: IconButton(
          icon: const Icon(Icons.map),
          onPressed: () {
            // TODO: Add map navigation or details page
          },
        ),
      ),
    );
  }
}
