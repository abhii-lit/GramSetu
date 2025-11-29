import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// This file is auto-generated after running flutterfire configure
import 'firebase_options.dart';

import 'package:gramsetu_app/screens/auth/splash_screen.dart';
import 'package:gramsetu_app/screens/dashboard/agent_dashboard.dart';
import 'package:gramsetu_app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with generated options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const GramSetuApp());
}

class GramSetuApp extends StatelessWidget {
  const GramSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GramSetu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
