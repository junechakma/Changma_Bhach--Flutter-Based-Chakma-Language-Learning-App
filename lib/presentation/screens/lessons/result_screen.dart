import 'package:changma_bhach/providers/lesson_provider.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);
    lessonProvider.resetLesson();
    return WillPopScope(
      onWillPop: () async {
        // Show the confirmation dialog
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm Exit'),
              content: const Text('Do you really want to go back to home?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
        // Return true if the user confirmed, otherwise false
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ResultScreen'),
        ),
        body: Center(
          child: Text(
              'This is the Result Screen ${lessonProvider.lessonWrongAnswer}'),
        ),
      ),
    );
  }
}
