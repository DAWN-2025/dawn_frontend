import 'package:flutter/material.dart';
import 'reusable_modal.dart';

class TourEndModal extends StatelessWidget {
  const TourEndModal({super.key, required this.onCheckLetter, required this.onLeaveComment, required this.onBackToTour});

  final VoidCallback onCheckLetter;
  final VoidCallback onLeaveComment;
  final VoidCallback onBackToTour;

  @override
  Widget build(BuildContext context) {
    return ReusableModal(
      title: 'OO will remember the time spent with you.\nYou got a letter from OO.\n\nWould you check it out in the album?\nYou can also continue tour with DAWN',
      primaryButtonText: 'Check the letter',
      secondaryButtonText: 'Leave a comment',
      onPrimaryPressed: onCheckLetter,
      onSecondaryPressed: onLeaveComment,
    );
  }
}

class BackToTourButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BackToTourButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text(
        'back to tour with DAWN',
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.black,
        ),
      ),
    );
  }
}
