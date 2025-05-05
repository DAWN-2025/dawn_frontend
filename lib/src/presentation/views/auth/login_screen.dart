import 'package:dawn_frontend/src/presentation/view_models/language_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/language_dropdown.dart';
import '../../widgets/custom_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final langVm = context.watch<LanguageViewModel>();

    return CustomScaffold(
      body: Stack(
        children: [
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
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                context.go('/'); // 👈 홈 화면으로 이동
              },
              child: Text(
                AppLocalizations.of(context)!.example,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
