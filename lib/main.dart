import 'dart:async';

import 'package:ash_personal_assistant/services/auth.dart';
import 'package:ash_personal_assistant/firebase_options.dart';
import 'package:ash_personal_assistant/pages/home_page.dart';
import 'package:ash_personal_assistant/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ash_personal_assistant/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:ash_personal_assistant/theme/font_styles.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(defaultFontLicense());
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: const ColorPalette().night));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const OnboardingPage();
          }
        },
      ),
    );
  }
}
