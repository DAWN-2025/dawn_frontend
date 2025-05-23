import 'package:flutter/material.dart';
import 'reusable_modal.dart';
import 'package:go_router/go_router.dart';

void TourStartModal(BuildContext context, {required int locationSeq}) {
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
              context.push('/ai-tour/$locationSeq');
            },
            onSecondaryPressed: () => Navigator.of(context).pop()
          );
        },
      );
    },
  );
}
