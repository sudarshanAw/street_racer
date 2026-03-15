import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/storage_helper.dart';
import 'screens/main_menu_screen.dart';

/// Entry point for Street Racer.
void main() async {
  // Ensure Flutter bindings are ready before using SharedPreferences.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local storage.
  await StorageHelper.init();

  // Lock to portrait mode for a consistent racing experience.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Dark status-bar icons on dark background.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUIOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const StreetRacerApp());
}

class StreetRacerApp extends StatelessWidget {
  const StreetRacerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Street Racer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const MainMenuScreen(),
    );
  }
}
