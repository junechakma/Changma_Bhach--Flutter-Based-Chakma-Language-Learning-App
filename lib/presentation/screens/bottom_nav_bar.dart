import 'package:changma_bhach/presentation/screens/home_screen.dart';
import 'package:changma_bhach/presentation/screens/report_screen.dart';
import 'package:changma_bhach/presentation/screens/translation_screen.dart';
import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          currentIndex: _selectedIndex,
          backgroundColor: AppColors.backgroundColor,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.black26,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const FaIcon(
                  FontAwesomeIcons.house,
                ),
                label: AppLocalizations.of(context)!.bottomBarHome),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.translate_rounded,
                ),
                label: AppLocalizations.of(context)!.bottomBarTranslations),
            // BottomNavigationBarItem(
            //     icon: const FaIcon(
            //       FontAwesomeIcons.squarePollHorizontal,
            //     ),
            //     label: AppLocalizations.of(context)!.bottomBarReport),
          ],
        ),
      ),
    );
  }
}
