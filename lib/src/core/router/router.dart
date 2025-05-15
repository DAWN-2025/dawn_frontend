import 'package:dawn_frontend/src/presentation/views/ai-tour/ai_tour_screen.dart'; // Ensure this file contains the AiTestScreen class definition
// If AiTestScreen is not defined, define it in the corresponding file or import the correct file.
import 'package:dawn_frontend/src/presentation/views/auth/sign_up_screen.dart';
import 'package:dawn_frontend/src/presentation/views/home/search_result_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../presentation/views/auth/sign_in_screen.dart';
import '../../presentation/views/home/home_screen.dart';
import '../../presentation/views/map/map_screen.dart';
import '../../presentation/views/album/album_screen.dart';
import '../../presentation/views/setting/setting_screen.dart';
import '../../presentation/views/details/event_detail_screen.dart';
import '../../presentation/views/details/location_detail_screen.dart';
import '../../presentation/view_models/details/event_detail_view_model.dart';
import '../../presentation/views/ai-tour/letter_screen.dart';
import '../../presentation/view_models/ai-tour/ai_tour_view_model.dart'; // Ensure this file contains the AiTourViewModel class definition

class AppRoutes {
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String home = '/';
  static const String search = '/search-result';
  static const String setting = '/setting';
  static const String map = '/map';
  static const String album = '/album';
  static const String eventDetail = '/event-detail/:eventId';
  static const String locationDetail = '/location-detail/:locationId';
  static const String aiTour = '/ai-tour/:locationSeq';
  static const String letter = '/letter/:locationSeq';
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
      GoRoute(
        path: AppRoutes.search,
        pageBuilder: (context, state) {
          final keyword = state.extra as String;
          return NoTransitionPage(child: SearchResultScreen(keyword: keyword));
        },
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
        builder: (context, state) {
          final int eventId =
              int.tryParse(state.pathParameters['eventId'] ?? '0') ?? 0;
          return EventDetailScreen(eventId: eventId);
        },
      ),
      // 장소 상세 화면
      GoRoute(
        path: AppRoutes.locationDetail,
        pageBuilder: (context, state) {
          final locationId =
              int.tryParse(state.pathParameters['locationId'] ?? '') ?? 0;
          return NoTransitionPage(
            child: LocationDetailScreen(locationId: locationId),
          );
        },
      ),
      // AI 테스트 화면
      GoRoute(
        path: AppRoutes.aiTour,
        builder: (context, state) {
          final locationSeq = int.tryParse(
            state.pathParameters['locationSeq'] ?? '',
          );
          return ChangeNotifierProvider(
            create: (_) => AiTourViewModel(locationSeq: locationSeq ?? 0),
            child: AiTourScreen(locationSeq: locationSeq ?? 0),
          );
        },
      ),
      // 편지 조회 화면
      GoRoute(
        path: AppRoutes.letter,
        builder: (context, state) {
          final locationSeq = int.tryParse(
            state.pathParameters['locationSeq'] ?? '',
          );
          return LetterScreen(locationSeq: locationSeq ?? 0);
        },
      ),
    ],
  );
}
