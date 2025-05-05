import 'package:flutter/material.dart';
import '../../widgets/language_dropdown.dart';
import '../../widgets/custom_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<LoginScreen> {
  String _selectedLang = '한국어';

  @override
  Widget build(BuildContext context) {
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
                value: _selectedLang,
                onChanged: (v) => setState(() => _selectedLang = v),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
