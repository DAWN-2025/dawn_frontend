import 'package:dawn_frontend/src/core/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/typography.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
            color: AppColors.darkGray,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text( AppLocalizations.of(context)!.or,
            style: AppTextStyle.bodyTextPoppins,
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
            color: AppColors.darkGray,
          ),
        ),
      ],
    );
  }
}
