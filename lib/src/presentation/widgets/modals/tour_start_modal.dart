import 'package:flutter/material.dart';
import 'reusable_modal.dart';

void TourStartModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Builder(
        builder: (BuildContext newContext) {
          return ReusableModal(
            title: 'Are you ready to go on tour with AI guide DAWN?',
            primaryButtonText: 'Start the tour',
            secondaryButtonText: 'Cancel',
            onPrimaryPressed: () {
              print('Tour started!');
            },
            onSecondaryPressed: () => Navigator.of(context).pop(),
          );
        },
      );
    },
  );
}
