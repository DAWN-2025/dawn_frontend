import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/views/auth/login_screen.dart';
import '../../presentation/views/home/home_screen.dart';
import '../../presentation/views/map/map_screen.dart';
import '../../presentation/views/album/album_screen.dart';
import '../../presentation/views/setting/setting_screen.dart';
import '../../presentation/views/details/event_detail_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/';
  static const String setting = '/setting';
  static const String map = '/map';
  static const String album = '/album';
  static const String eventDetail = '/event-detail';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      // 로그인 화면
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) => NoTransitionPage(child: LoginScreen()),
      ),
      // 홈 화면
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => NoTransitionPage(child: HomeScreen()),
      ),
      // 지도 화면
      GoRoute(
        path: AppRoutes.map,
        pageBuilder: (context, state) => NoTransitionPage(child: MapScreen()),
      ),
      // 앨범 화면
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
      // 사건 상세 화면
      GoRoute(
        path: AppRoutes.eventDetail,
        pageBuilder:
            (context, state) => NoTransitionPage(child: EventDetailScreen()),
      ),
    ],
  );
}
