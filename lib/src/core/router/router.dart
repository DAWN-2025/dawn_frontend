import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/views/home/home.dart';
import '../../presentation/views/setting/setting.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // 홈 화면
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      // 환경 설정 화면
      GoRoute(
        path: '/setting',
        builder: (context, state) => const SettingScreen(),
      ),
    ],
  );
}
