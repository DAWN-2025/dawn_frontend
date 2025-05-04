import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/views/home/home_screen.dart';
import '../../presentation/views/map/map_screen.dart';
import '../../presentation/views/album/album_screen.dart';
import '../../presentation/views/setting/setting_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String setting = '/setting';
  static const String map = '/map';
  static const String album = '/album';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      // 홈 화면
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => NoTransitionPage(child: HomeScreen()),
      ),
      // 지도 화면
      GoRoute(
        path: AppRoutes.map,
        pageBuilder:
            (context, state) => NoTransitionPage(child: MapScreen()),
      ),
      // 지도 화면
      GoRoute(
        path: AppRoutes.album,
        pageBuilder: (context, state) => NoTransitionPage(child: AlbumScreen()),
      ),
      // 환경 설정 화면
      GoRoute(
        path: AppRoutes.setting,
        pageBuilder:
            (context, state) => NoTransitionPage(child: SettingScreen()),
      ),
    ],
  );
}
