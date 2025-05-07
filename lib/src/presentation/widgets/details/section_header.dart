import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class SectionHeader extends StatelessWidget {
  final String text;

  const SectionHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: typography.AppTextStyle.heading3.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
