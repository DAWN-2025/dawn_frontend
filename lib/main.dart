import 'package:dawn_frontend/src/data/local/app_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'src/core/state/app_state.dart';
import 'package:dawn_frontend/src/presentation/view_models/custom_bottom_app_bar_viewmodel.dart';
import 'package:dawn_frontend/src/presentation/view_models/language_view_model.dart';

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
      ],
      child: const MyApp(),
    ),
  );
}
