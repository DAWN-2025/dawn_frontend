import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dawn_frontend/src/presentation/widgets/common/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/common/custom_bottom_app_bar.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/constants/constants.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return CustomScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                local.settingsIntroMessage,
                textAlign: TextAlign.center,
                style: AppTextStyle.bodyText.copyWith(
                  fontSize: 15,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),

              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    const ClipboardData(text: Strings.teamEmail),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(local.emailCopied),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  Strings.teamEmail,
                  style: const TextStyle(
                    color: Color(0xFF816161),
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
