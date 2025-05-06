import 'package:dawn_frontend/src/core/theme/typography.dart';
import 'package:dawn_frontend/src/core/utils/constants.dart';
import 'package:dawn_frontend/src/presentation/view_models/language_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/language_dropdown.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/auth/sign_in_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final langVm = context.watch<LanguageViewModel>();

    return CustomScaffold(
      body: Stack(
        children: [
          // 1. 언어 선택 드롭다운
          Positioned(
            top: 60,
            right: 16,
            child: SizedBox(
              width: 86,
              height: 35,
              child: LanguageDropdown(
                value: langVm.display,
                onChanged: (v) {
                  setState(() {
                    langVm.changeLanguage(v);
                  });
                },
              ),
            ),
          ),
          // 로고 ~
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 110),
                // 2. 로고
                SvgPicture.asset(
                  'assets/icons/logo_main.svg',
                  width: 240,
                  height: 134,
                ),
                const SizedBox(height: 45),
                // 3. 로그인 카드
                const SignInCard(),
                const SizedBox(height: 55),
                // 4. 출처
                Padding(
                  padding: const EdgeInsets.only(bottom: 33),
                  child: const Text(
                    Strings.source,
                    style: AppTextStyle.sourceText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}