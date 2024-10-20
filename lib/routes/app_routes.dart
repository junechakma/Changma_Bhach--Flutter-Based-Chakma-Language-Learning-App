import 'package:changma_bhach/presentation/screens/bottom_nav_bar.dart';
import 'package:changma_bhach/presentation/screens/home_screen.dart';
import 'package:changma_bhach/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String welcome = "/welcome";
  static const String home = "/home";
  static const String bottomNav = "/bottomNav";

  static Map<String, WidgetBuilder> buildRoutes() {
    return {
      welcome: (context) => const WelcomeScreen(),
      home: (context) => const HomeScreen(),
      bottomNav: (context) => const BottomNavBar(),
    };
  }
}
