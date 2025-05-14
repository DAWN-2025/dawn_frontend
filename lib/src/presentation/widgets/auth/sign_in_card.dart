import 'package:dawn_frontend/src/presentation/widgets/auth/auth_input_field.dart';
import 'package:dawn_frontend/src/presentation/widgets/auth/continue_btn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:dawn_frontend/src/presentation/widgets/auth/divider_or.dart';
import '../../../core/router/router.dart';
import '../../view_models/auth/sign_in_view_model.dart';
import 'google_login_btn.dart';

class SignInCard extends StatelessWidget {
  const SignInCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SignInViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context)!;
    final router = GoRouter.of(context);

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
            onChanged: (String? value) {
              viewModel.setEmail(value);
            },
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
            onChanged: (String? value) {
              viewModel.setPassword(value);
            },
          ),
          const SizedBox(height: 25),
          Center(
            child: Column(
              children: [
                ContinueButton(
                  onPressed: () async {
                    final result = await viewModel.validateAndLogin();
                    if (kDebugMode) {
                      print('Sign-in result: $result');
                    }
                    if (result != null) {
                      router.go(AppRoutes.home);
                      //router.go(AppRoutes.aiTest);
                    } else {}
                  },
                ),
                const SizedBox(height: 18),
                const OrDivider(),
                const SizedBox(height: 18),
                GoogleLoginBtn(
                  onPressed: () async {
                    final result = await viewModel.validateAndLogin();
                    if (kDebugMode) {
                      print('Google sign-in result: $result');
                    }
                    if (result != null) {
                      context.go(AppRoutes.home);
                    } else {}
                  },
                ),
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
                        context.push(AppRoutes.signUp);
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
