import 'package:changma_bhach/presentation/screens/bottom_nav_bar.dart';
import 'package:changma_bhach/presentation/screens/home_screen.dart';
import 'package:changma_bhach/presentation/screens/lessons/drawing_screen.dart';
import 'package:changma_bhach/presentation/screens/lessons/lesson_screen.dart';
import 'package:changma_bhach/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String welcome = "/welcome";
  static const String home = "/home";
  static const String bottomNav = "/bottomNav";
  static const String lessonScreen = "/lessonScreen";
  static const String drawingScreen = "/drawingScreen";

  static Map<String, WidgetBuilder> buildRoutes() {
    return {
      welcome: (context) => const WelcomeScreen(),
      home: (context) => const HomeScreen(),
      bottomNav: (context) => const BottomNavBar(),
      lessonScreen: (context) => const LessonScreen(),
      drawingScreen: (context) => const DrawingScreen(),
    };
  }
}
