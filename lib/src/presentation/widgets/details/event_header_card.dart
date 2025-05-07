import 'package:flutter/material.dart';
import 'tag_chip.dart';
import 'tab_selector.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class EventHeaderCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final int selectedIndex;
  final void Function(int) onTabSelected;

  const EventHeaderCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: (Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: typography.AppTextStyle.heading3),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: tags.map((tag) => TagChip(label: tag)).toList(),
            ),
            const SizedBox(height: 12),
            Text(description, style: typography.AppTextStyle.bodyTextPoppins),
            const SizedBox(height: 16),
            // DetailTabSelector(
            //   labels: const ['details', 'locations'],
            //   selectedIndex: selectedIndex,
            //   onTap: onTabSelected,
            // ),
          ],
        ),
      )),
    );
  }
}
