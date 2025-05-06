import 'package:dawn_frontend/src/core/extensions/localization_extensions.dart';
import 'package:dawn_frontend/src/presentation/widgets/auth/auth_input_field.dart';
import 'package:dawn_frontend/src/presentation/widgets/auth/continue_btn.dart';
import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:dawn_frontend/src/presentation/widgets/auth/divider_or.dart';
import '../../../core/router/router.dart';
import '../../view_models/auth/sign_up_view_model.dart';
import 'google_login_btn.dart';

class SignUpCard extends StatefulWidget {
  const SignUpCard({super.key});

  @override
  State<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        // 비밀번호 입력 필드에서 포커스가 벗어났을 때
        final viewModel = context.read<SignUpViewModel>();
        if (!viewModel.isPasswordValid) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.error_weak_password),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpViewModel>(context, listen: false);
    return Container(
      width: 300,
      height: 518,
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
            AppLocalizations.of(context)!.sign_up,
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
            onChanged: viewModel.setEmail,
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
            onChanged: viewModel.setPassword,
            focusNode: _passwordFocusNode, // 비밀번호 입력 필드에 포커스 노드 추가
            obscure: true,
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.check_password,
            style: AppTextStyle.bodyTextPoppins,
          ),
          const SizedBox(height: 2),
          AuthInputField(
            icon: SvgPicture.asset(
              'assets/icons/success.svg',
              width: 24,
              height: 24,
            ),
            onChanged: viewModel.setConfirmPassword,
            obscure: true,
          ),
          const SizedBox(height: 25),
          Center(
            child: Column(
              children: [
                ContinueButton(
                  onPressed: () async {
                    final viewModel = context.read<SignUpViewModel>();
                    final messenger = ScaffoldMessenger.of(context);
                    final l10n = AppLocalizations.of(context)!;
                    final router = GoRouter.of(context);
                    final result = await viewModel.signUp();
                    if (result != null) {
                      final message = l10n.getByKey(result);
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(message),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } else {
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(l10n.email_verification_sent),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                      await Future.delayed(const Duration(seconds: 3));
                      router.go(AppRoutes.signIn);
                    }
                  },
                ),
                const SizedBox(height: 18),
                const OrDivider(),
                const SizedBox(height: 18),
                GoogleLoginBtn(onPressed: () {}),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.sign_in_description,
                      style: AppTextStyle.bodyTextPoppins.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        context.go(AppRoutes.signIn);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.sign_in_btn,
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
