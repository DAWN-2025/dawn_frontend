import 'package:dawn_frontend/src/presentation/widgets/auth/sign_up_card.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      appBar: const CustomTopAppBar(isDark: true),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(  // 📌 중앙 정렬을 보장하기 위해 추가
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center, // 전체 중앙 정렬
              children: [
                const SizedBox(height: 15),

                // 2. 로고
                SvgPicture.asset(
                  'assets/icons/logo_sub.svg',
                  width: 215,
                  height: 44,
                ),

                const SizedBox(height: 60),

                // 3. 회원 가입 카드
                const SignUpCard(),

                const SizedBox(height: 48),

                // 4. 출처
                Text(Strings.source, style: AppTextStyle.sourceText),

                const SizedBox(height: 33),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
