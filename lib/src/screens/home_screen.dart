// 임시 코드

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('홈 화면')),
      body: Center(
        child: InkWell(
          onTap: () {
            context.go('/setting');
          },
          child: const Text('환경 설정 화면으로 전환'),
        ),
      ),
    );
  }
}
