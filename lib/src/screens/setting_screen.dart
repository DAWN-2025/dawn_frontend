// 임시 코드

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("환경 설정 화면")),
      body: Center(
        child: InkWell(
          onTap: () {
            context.go('/');
          },
          child: const Text('홈으로 돌아가기'),
        ),
      ),
    );
  }
}
