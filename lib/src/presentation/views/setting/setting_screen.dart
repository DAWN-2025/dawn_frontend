import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/core/router/router.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            context.go(AppRoutes.home);
          },
          child: const Text(
            '홈 화면으로 전환',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
