import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/views/home/home.dart';
import '../../presentation/views/setting/setting.dart';

class AppRoutes {
  static const String home = '/';
  static const String setting = '/setting';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      // 홈 화면
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      // 환경 설정 화면
      GoRoute(
        path: AppRoutes.setting,
        builder: (context, state) => const SettingScreen(),
      ),
    ],
  );
}
