import 'package:dawn_frontend/src/presentation/widgets/auth/sign_up_card.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/back_btn.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // 1. 뒤로 가기 버튼
              BackBtn(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 40),
              // 2. 로고
              Center(
                child: SvgPicture.asset(
                  'assets/icons/logo_sub.svg',
                  width: 215,
                  height: 44,
                ),
              ),
              const SizedBox(height: 60),
              // 3. 회원 가입 카드
              Center(child: SignUpCard()),
              const SizedBox(height: 60),
              // 4. 출처
              Center(
                child: Text(Strings.source, style: AppTextStyle.sourceText),
              ),
              const SizedBox(height: 33),
            ],
          ),
        ),
      ),
    );
  }
}
