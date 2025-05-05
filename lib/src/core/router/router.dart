import 'package:dawn_frontend/src/presentation/views/auth/sing_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/views/auth/sign_in_screen.dart';
import '../../presentation/views/home/home_screen.dart';
import '../../presentation/views/map/map_screen.dart';
import '../../presentation/views/album/album_screen.dart';
import '../../presentation/views/setting/setting_screen.dart';
import '../../presentation/views/details/event_detail_screen.dart';

class AppRoutes {
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String home = '/';
  static const String setting = '/setting';
  static const String map = '/map';
  static const String album = '/album';
  static const String eventDetail = '/event-detail/:id';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.signIn, // 초기 경로
    routes: [
      // 로그인 화면
      GoRoute(
        path: AppRoutes.signIn,
        pageBuilder:
            (context, state) => NoTransitionPage(child: SignInScreen()),
      ),
      // 회원 가입 화면
      GoRoute(
        path: AppRoutes.signUp,
        pageBuilder:
            (context, state) => NoTransitionPage(child: SignUpScreen()),
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
        pageBuilder: (context, state) {
          final eventId = state.pathParameters['id'];
          return NoTransitionPage(child: EventDetailScreen(eventId: eventId!));
        },
      ),
    ],
  );
}
