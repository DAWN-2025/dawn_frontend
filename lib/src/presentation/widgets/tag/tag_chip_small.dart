import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class TagChipSmall extends StatelessWidget {
  final String label;

  const TagChipSmall({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: typography.AppTextStyle.tagText.copyWith(fontSize: 8),
      ),
    );
  }
}
