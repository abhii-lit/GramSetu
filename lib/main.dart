import 'package:flutter/material.dart';
import 'package:gramsetu_app/screens/auth/splash_screen.dart';
import 'package:gramsetu_app/screens/dashboard/agent_dashboard.dart';
import 'package:gramsetu_app/theme/app_theme.dart';

void main() {
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
