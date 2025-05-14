import 'package:flutter/material.dart';
import 'reusable_modal.dart';

class TourEndModal extends StatelessWidget {
  const TourEndModal({
    super.key,
    required this.onCheckLetter,
    required this.onGoToHome,
  });

  final VoidCallback onCheckLetter;
  final VoidCallback onGoToHome;

  @override
  Widget build(BuildContext context) {
    return ReusableModal(
      title: 'They will remember the time spent with you.\nYou got a letter.\n\nWould you check it out in the album?',
      primaryButtonText: 'Check the letter',
      secondaryButtonText: 'Back to Home',
      onPrimaryPressed: onCheckLetter,
      onSecondaryPressed: onGoToHome,
      //footer: BackToTourButton(onPressed: onBackToTour),
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
        'Back to tour with DAWN',
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.black,
        ),
      ),
    );
  }
}
