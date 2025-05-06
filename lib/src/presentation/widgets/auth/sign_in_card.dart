import 'package:dawn_frontend/src/presentation/widgets/auth/auth_input_field.dart';
import 'package:dawn_frontend/src/presentation/widgets/auth/continue_btn.dart';
import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:dawn_frontend/src/presentation/widgets/auth/divider_or.dart';
import '../../../core/router/router.dart';
import 'google_login_btn.dart';

class SignInCard extends StatelessWidget {
  const SignInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 440,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      //내부 여백
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15), // 위쪽 여백
          Text(
            AppLocalizations.of(context)!.sign_in,
            style: AppTextStyle.heading3,
          ),
          const SizedBox(height: 18),
          Text(
            AppLocalizations.of(context)!.email,
            style: AppTextStyle.bodyTextPoppins,
          ),
          const SizedBox(height: 2),
          AuthInputField(
            icon: SvgPicture.asset(
              'assets/icons/email.svg',
              width: 20,
              height: 20,
            ),
            onChanged: (String? value) {},
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.password,
            style: AppTextStyle.bodyTextPoppins,
          ),
          AuthInputField(
            icon: SvgPicture.asset(
              'assets/icons/password.svg',
              width: 24,
              height: 24,
            ),
            obscure: true,
            onChanged: (String? value) {},
          ),
          const SizedBox(height: 25),
          Center(
            child: Column(
              children: [
                ContinueButton(onPressed: () {}),
                const SizedBox(height: 18),
                const OrDivider(),
                const SizedBox(height: 18),
                GoogleLoginBtn(onPressed: () {}),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.sign_up_description,
                      style: AppTextStyle.bodyTextPoppins.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        context.go(AppRoutes.signUp);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.sign_up_btn,
                        style: AppTextStyle.bodyTextPoppins.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
