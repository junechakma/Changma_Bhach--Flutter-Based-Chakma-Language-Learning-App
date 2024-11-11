import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          backgroundColor: AppColors.backgroundColor,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: AppColors.backgroundColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Overall Performance Section
              Column(
                children: [
                  _buildPerformanceHeader(lessonProvider),
                  const SizedBox(height: 20),
                  _buildScoreBreakdown(lessonProvider),
                ],
              ),

              // Detailed Score Breakdown

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
        const SizedBox(height: 20),
        // Text(
        //   '$performancePercentage%',
        //   style: const TextStyle(
        //     fontSize: 36,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.white,
        //   ),
        // ),
        CircularPercentIndicator(
          radius: 90.0,
          lineWidth: 20.0,
          animation: true,
          percent: double.parse(performancePercentage) / 100,
          center: Text(
            "$performancePercentage %",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have total  ',
              style: TextStyles.categoryHeading,
            ),
            Text(
              '${lessonProvider.lessonCorrectAnswer + lessonProvider.lessonWrongAnswer} atempts ',
              style:
                  TextStyles.categoryHeading.copyWith(color: AppColors.danger),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildScoreRow(
              'Correct Answers',
              lessonProvider.lessonCorrectAnswer,
              color: AppColors.primary,
            ),
            _buildScoreRow('Wrong Answers', lessonProvider.lessonWrongAnswer,
                color: AppColors.dangerRed),
          ],
        ),
      ]),
    );
  }

  Widget _buildScoreRow(String label, int value, {Color? color}) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? Colors.grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(
                width: 40,
              ),
              FaIcon(
                color == AppColors.primary
                    ? FontAwesomeIcons.checkDouble
                    : FontAwesomeIcons.xmark, // Corrected icon selection
                color: AppColors.backgroundColor, // Adjust color if needed
                size: 28, // Adjust icon size if too big/small
              ),
            ],
          ),
          const SizedBox(height: 4), // Add spacing between text and label
          Text(
            label,
            style: TextStyles.subHeadingText.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.pushReplacementNamed(context, AppRoutes.lessonScreen);
        //     Provider.of<LessonProvider>(context, listen: false).resetLesson();
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.grey[300],
        //     foregroundColor: AppColors.dark,
        //   ),
        //   child: const Row(
        //     children: [
        //       Text('Retry'),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       FaIcon(FontAwesomeIcons.rotateRight)
        //     ],
        //   ),
        // ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.backgroundColor,
          ),
          onPressed: () {
            // Navigate back to home
            Navigator.pushReplacementNamed(context, AppRoutes.bottomNav);
            Provider.of<LessonProvider>(context, listen: false).resetLesson();
          },
          child: const Row(
            children: [
              Text('Home'),
              SizedBox(
                width: 10,
              ),
              FaIcon(FontAwesomeIcons.house)
            ],
          ),
        ),
      ],
    );
  }

  // Helper method to determine performance color based on percentage
  Color _getPerformanceColor(double percentage) {
    if (percentage >= 80) return AppColors.primary;
    if (percentage >= 50) return AppColors.danger;
    return AppColors.dangerRed;
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
