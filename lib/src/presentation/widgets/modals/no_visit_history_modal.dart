import 'package:flutter/material.dart';
import 'reusable_modal.dart';

class NoVisitHistoryModal extends StatelessWidget {
  const NoVisitHistoryModal({super.key, required this.onGoToDetail});

  final VoidCallback onGoToDetail;

  @override
  Widget build(BuildContext context) {
    return ReusableModal(
      title: 'There is no visit history.\nWould you like to check the details?',
      primaryButtonText: 'Go to details',
      secondaryButtonText: 'Cancel',
      onPrimaryPressed: onGoToDetail,
      onSecondaryPressed: () => Navigator.of(context).pop(),
    );
  }
}
