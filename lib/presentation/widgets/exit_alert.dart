import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExitAlert extends StatelessWidget {
  final String? navigateToRoute;

  const ExitAlert({
    super.key,
    this.navigateToRoute = AppRoutes.bottomNav,
  });

  static Future<void> show(BuildContext context, {String? navigateToRoute}) {
    return showDialog(
      context: context,
      builder: (context) => ExitAlert(navigateToRoute: navigateToRoute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.confirm_exit_title),
      content: Text(AppLocalizations.of(context)!.confirm_exit_message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(AppLocalizations.of(context)!.cancel_button),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.bottomNav);
          },
          child: Text(AppLocalizations.of(context)!.yes_button),
        ),
      ],
    );
  }
}
