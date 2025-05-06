import 'package:dawn_frontend/src/data/local/app_preferences.dart';
import 'package:dawn_frontend/src/domain/repositories/auth_repository.dart';
import 'package:dawn_frontend/src/presentation/view_models/auth/sign_in_view_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/auth/sign_up_view_model.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final appPrefs = AppPreferences(prefs);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        ChangeNotifierProvider(
          create:
              (_) => StampCardListViewModel(repository: StampCardRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
