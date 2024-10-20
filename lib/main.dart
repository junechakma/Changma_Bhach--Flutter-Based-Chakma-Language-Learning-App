import 'package:changma_bhach/presentation/screens/welcome_screen.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Changma Bhach',
      home: const WelcomeScreen(),
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.buildRoutes(),
    );
  }
}
