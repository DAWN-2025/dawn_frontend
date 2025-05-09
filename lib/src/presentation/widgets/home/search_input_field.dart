import 'package:dawn_frontend/src/core/theme/typography.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/colors.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearchTap;

  const SearchInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    final localizedHintText =
        hintText ?? AppLocalizations.of(context)!.search_hint;

    return SizedBox(
        height: 45,
        width: 310,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: AppTextStyle.detailBodyText.copyWith(
              color: AppColors.darkGray),
          decoration: InputDecoration(
            hintText: localizedHintText,
            hintStyle: AppTextStyle.detailBodyText.copyWith(
              color: AppColors.darkGray,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(Icons.search, color: AppColors.darkGray),
            ),
            suffixIcon:
            onSearchTap != null
                ? IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: onSearchTap,
            )
                : null,
            filled: true,
            fillColor: Colors.white,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 11.5),
          ),
        )
    );
  }
}
