import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:changma_bhach/providers/lesson_provider.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);
    // final resetLesson = lessonProvider.resetLesson();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        showExitConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lesson Result'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: AppColors.bgWhite),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Overall Performance Section
              _buildPerformanceHeader(lessonProvider),

              const SizedBox(height: 20),

              // Detailed Score Breakdown
              _buildScoreBreakdown(lessonProvider),

              const SizedBox(height: 20),

              // Action Buttons
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerformanceHeader(LessonProvider lessonProvider) {
    // Calculate overall performance percentage
    final totalQuestions =
        lessonProvider.lessonCorrectAnswer + lessonProvider.lessonWrongAnswer;
    final performancePercentage = totalQuestions > 0
        ? (lessonProvider.lessonCorrectAnswer / totalQuestions * 100)
            .toStringAsFixed(1)
        : '0.0';

    return Column(
      children: [
        const Text(
          ' Performance ',
          style: TextStyles.categoryHeading,
        ),

        const SizedBox(height: 10),
        // Text(
        //   '$performancePercentage%',
        //   style: const TextStyle(
        //     fontSize: 36,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.white,
        //   ),
        // ),

        CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 20.0,
          animation: true,
          percent: double.parse(performancePercentage) / 100,
          center: Text(
            "$performancePercentage %",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor:
              _getPerformanceColor(double.parse(performancePercentage)),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildScoreBreakdown(LessonProvider lessonProvider) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        const Text(
          'You Have Total ',
          style: TextStyles.categoryHeading,
        ),
        Text(
          '${lessonProvider.lessonCorrectAnswer + lessonProvider.lessonWrongAnswer} Atempts ',
          style: TextStyles.categoryHeading,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildScoreRow(
                'Correct Answers', lessonProvider.lessonCorrectAnswer,
                color: Colors.green),
            _buildScoreRow('Wrong Answers', lessonProvider.lessonWrongAnswer,
                color: Colors.blue),
          ],
        ),
      ]),
    );
  }

  Widget _buildScoreRow(String label, int value, {Color? color}) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Icon(Icons.fork_right)
            ],
          ),
          Text(
            label,
            style: TextStyles.subHeadingText.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkBlue,
            foregroundColor: AppColors.mistyRose,
          ),
          onPressed: () {
            // Navigate back to home
            Navigator.pushReplacementNamed(context, AppRoutes.bottomNav);
            Provider.of<LessonProvider>(context, listen: false).resetLesson();
          },
          child: const Text('Home'),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.pushReplacementNamed(context, AppRoutes.lessonScreen);
        //     Provider.of<LessonProvider>(context, listen: false).resetLesson();
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: AppColors.lightBlue,
        //     foregroundColor: AppColors.bgWhite,
        //   ),
        //   child: const Text('Retry Lesson'),
        // ),
      ],
    );
  }

  // Helper method to determine performance color based on percentage
  Color _getPerformanceColor(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 50) return Colors.orange;
    return Colors.red;
  }
}

Future<bool> showExitConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Exit'),
        content:
            const Text('Do you really want to go back to the home screen?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Dismisses dialog without exiting
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.bottomNav);
              Provider.of<LessonProvider>(context, listen: false).resetLesson();
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
