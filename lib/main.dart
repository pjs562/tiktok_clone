import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/constants/features/discover/activity_screen.dart';
import 'package:tiktok_clone/constants/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/constants/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/constants/sizes.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      theme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const ActivityScreen(),
    );
  }
}
