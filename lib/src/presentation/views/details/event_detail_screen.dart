import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_bottom_app_bar.dart';

class EventDetailScreen extends StatelessWidget {
  final String eventId;

  const EventDetailScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Center(
          child: Text(
            'Event ID: $eventId',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
