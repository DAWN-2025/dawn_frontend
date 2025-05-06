import 'package:flutter/material.dart';
import 'tag_chip.dart';
import 'detail_tap_button.dart';

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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: tags.map((tag) => TagChip(label: tag)).toList(),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DetailTabButton(
                  label: 'Details',
                  selected: selectedIndex == 0,
                  onTap: () => onTabSelected(0),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DetailTabButton(
                  label: 'Location',
                  selected: selectedIndex == 1,
                  onTap: () => onTabSelected(1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
