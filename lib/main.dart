import 'package:changma_bhach/presentation/screens/welcome_screen.dart';
import 'package:changma_bhach/providers/locale_provider.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocaleProvider>(context, listen: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Changma Bhach',
      locale: localProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("en"), Locale("bn")],
      home: const WelcomeScreen(),
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.buildRoutes(),
    );
  }
}
