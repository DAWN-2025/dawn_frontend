import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/core/theme/colors.dart';
import '../../../../l10n/app_localizations.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: 180,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Color(0xFF333333),
          // 텍스트 색
          backgroundColor: Colors.white,
          side: const BorderSide(color: AppColors.darkGray),
          // 테두리 색상
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // 타원형 둥근 버튼
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        child: Text(AppLocalizations.of(context)!.login_btn),
      ),
    );
  }
}
