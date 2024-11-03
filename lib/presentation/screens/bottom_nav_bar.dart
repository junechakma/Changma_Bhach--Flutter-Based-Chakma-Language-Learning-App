import 'package:changma_bhach/presentation/screens/home_screen.dart';
import 'package:changma_bhach/presentation/screens/report_screen.dart';
import 'package:changma_bhach/presentation/screens/translation_screen.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Navigator.pushNamed(context, AppRoutes.welcome);
      },
      child: Scaffold(
        body: appScreens.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppLocalizations.of(context)!.bottomBarHome),
            BottomNavigationBarItem(
                icon: const Icon(Icons.translate),
                label: AppLocalizations.of(context)!.bottomBarTranslations),
            BottomNavigationBarItem(
                icon: const Icon(Icons.bar_chart_outlined),
                label: AppLocalizations.of(context)!.bottomBarReport),
          ],
        ),
      ),
    );
  }
}
