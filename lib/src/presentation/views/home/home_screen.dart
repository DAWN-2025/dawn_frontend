import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/core/router/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            context.go(AppRoutes.setting);
          },
          child: const Text(
            '환경 설정 화면으로 전환',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
