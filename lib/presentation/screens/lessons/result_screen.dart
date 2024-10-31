import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        _showBackDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ResultScreen"),
        ),
      ),
    );
  }
}

Future<bool?> _showBackDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          'Are you sure you want to leave this page?',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Nevermind'),
            onPressed: () {
              Navigator.pop(context, false); // Close dialog without action
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Go to Home'),
            onPressed: () {
              Navigator.pop(context, true); // Close the dialog
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (Route<dynamic> route) => false, // Clear all routes
              );
            },
          ),
        ],
      );
    },
  );
}
