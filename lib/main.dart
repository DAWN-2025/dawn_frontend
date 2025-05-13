import 'package:dawn_frontend/src/data/local/app_preferences.dart';
import 'package:dawn_frontend/src/domain/repositories/auth_repository.dart';
import 'package:dawn_frontend/src/presentation/view_models/auth/sign_in_view_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/auth/sign_up_view_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/home/event_cards_view_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/home/weekly_featured_view_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/map/map_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'src/core/state/app_state.dart';
import 'package:dawn_frontend/src/presentation/view_models/custom_bottom_app_bar_viewmodel.dart';
import 'package:dawn_frontend/src/presentation/view_models/language_view_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/stamp_card_list_view_model.dart';
import 'package:dawn_frontend/src/domain/repositories/stamp_card_repository.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/event_detail_view_model.dart';
import 'package:dawn_frontend/src/domain/repositories/details/event_detail_repository.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/detail_tab_selector_view_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/location_detail_view_model.dart';
import 'package:dawn_frontend/src/domain/repositories/details/location_detail_repository.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/comment_view_model.dart';
import 'package:dawn_frontend/src/domain/repositories/details/comment_repository.dart';
import 'package:dawn_frontend/src/presentation/view_models/ai-tour/explore_now_btn_view_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/modals/modal_view_model.dart';

// import 'package:dawn_frontend/src/presentation/widgets/modals/tour_start_modal.dart';
// import 'package:dawn_frontend/src/presentation/widgets/modals/delete_comment_modal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final appPrefs = AppPreferences(prefs);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await forceLogout();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => BottomAppBarViewModel()),
        ChangeNotifierProvider(create: (_) => LanguageViewModel(appPrefs)),
        ChangeNotifierProvider(
          create: (_) => SignUpViewModel(AuthRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => SignInViewModel(AuthRepository()),
        ),
        ChangeNotifierProvider(create: (_) => WeeklyFeaturedViewModel()),
        ChangeNotifierProvider(create: (_) => EventCardsViewModel()),
        ChangeNotifierProvider(create: (_) => MapViewModel()),
        ChangeNotifierProvider(
          create:
              (_) => StampCardListViewModel(repository: StampCardRepository()),
        ),
        ChangeNotifierProvider(
          create:
              (_) => EventDetailViewModel(repository: EventDetailRepository()),
        ),
        ChangeNotifierProvider(create: (_) => DetailTabSelectorViewModel()),
        Provider<CommentRepository>(create: (_) => CommentRepository()),
        ChangeNotifierProvider<CommentViewModel>(
          create:
              (context) => CommentViewModel(
                commentRepository: context.read<CommentRepository>(),
              ),
        ),
        Provider<LocationDetailRepository>(
          create: (_) => LocationDetailRepository(),
        ),
        ChangeNotifierProvider<LocationDetailViewModel>(
          create:
              (context) => LocationDetailViewModel(
                repository: context.read<LocationDetailRepository>(),
                commentViewModel: context.read<CommentViewModel>(),
              ),
        ),
        ChangeNotifierProvider(create: (_) => ExploreNowBtnViewModel()),
        ChangeNotifierProvider(create: (_) => ModalViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}
