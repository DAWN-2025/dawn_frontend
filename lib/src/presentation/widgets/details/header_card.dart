import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/presentation/widgets/tag/tag_chip.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/detail_tab_selector.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/detail_tab_selector_view_model.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class HeaderCard extends StatelessWidget {
  final String title;
  final String? date;
  final String? location;
  final List<String>? tags;
  final String? description;
  final List<String> tabLabels;
  //final DetailTabType type;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const HeaderCard({
    Key? key,
    required this.title,
    this.date,
    this.location,
    this.tags,
    this.description,
    required this.tabLabels,
    //required this.type,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return AspectRatio(
    //   aspectRatio: 4 / 3,
    //   child: (
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: typography.AppTextStyle.heading2,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),

          // Date and Location Row
          if (date != null || location != null) _buildDateLocationRow(),

          // Tags
          if (tags != null && tags!.isNotEmpty) _buildTags(),

          // Description
          if (description != null) _buildDescription(),

          const SizedBox(height: 16),

          // Tab Selector
          DetailTabSelector(
            labels: tabLabels,
            selectedIndex: selectedIndex,
            onTap: (index) {
              print("HeaderCard: tab selected: $index"); // 디버깅용
              onTabSelected(index); // 전달된 콜백 실행
            },
          ),
        ],
      ),
      // )),
    );
  }

  /// Date and Location Row
  Widget _buildDateLocationRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          if (date != null) ...[
            const Icon(Icons.calendar_today, size: 16),
            const SizedBox(width: 8),
            Text(date!, style: typography.AppTextStyle.bodyTextPoppins),
          ],
          if (date != null && location != null) const SizedBox(width: 16),
          if (location != null) ...[
            const Icon(Icons.location_on, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                location!,
                style: typography.AppTextStyle.bodyTextPoppins,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Tags Chip
  Widget _buildTags() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Wrap(
        spacing: 8,
        children: tags!.map((tag) => TagChip(label: tag)).toList(),
      ),
    );
  }

  /// Description Text
  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        description!,
        style: typography.AppTextStyle.bodyTextPoppins,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
