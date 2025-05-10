import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/presentation/widgets/modals/reusable_modal.dart';

class TourRecordModal extends StatelessWidget {
  const TourRecordModal({super.key, required this.onStartNewTour, required this.onContinueTour});

  final VoidCallback onStartNewTour;
  final VoidCallback onContinueTour;

  @override
  Widget build(BuildContext context) {
    return ReusableModal(
      title: 'There\'s a record of tour already',
      primaryButtonText: 'Start a new tour',
      secondaryButtonText: 'Continue past tour',
      onPrimaryPressed: onStartNewTour,
      onSecondaryPressed: onContinueTour,
    );
  }
}

