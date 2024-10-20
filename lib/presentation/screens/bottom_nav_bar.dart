import 'package:changma_bhach/presentation/screens/home_screen.dart';
import 'package:changma_bhach/presentation/screens/report_screen.dart';
import 'package:changma_bhach/presentation/screens/translation_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  List<dynamic> appScreens = [
    const HomeScreen(),
    const TranslationScreen(),
    const ReportScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appScreens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.translate), label: "Translations"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined), label: "Report"),
        ],
      ),
    );
  }
}
