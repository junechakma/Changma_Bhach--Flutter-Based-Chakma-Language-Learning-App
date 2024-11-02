import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:changma_bhach/providers/lesson_provider.dart';
import 'package:changma_bhach/routes/app_routes.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);
    final resetLesson = lessonProvider.resetLesson();

    return WillPopScope(
      onWillPop: () async {
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
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.home);
                    resetLesson;
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lesson Result'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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

    return Card(
      color: _getPerformanceColor(double.parse(performancePercentage)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Your Performance',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$performancePercentage%',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreBreakdown(LessonProvider lessonProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildScoreRow(
                'Total Questions',
                lessonProvider.lessonCorrectAnswer +
                    lessonProvider.lessonWrongAnswer),
            const Divider(),
            _buildScoreRow(
                'Correct Answers', lessonProvider.lessonCorrectAnswer,
                color: Colors.green),
            _buildScoreRow('Wrong Answers', lessonProvider.lessonWrongAnswer,
                color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreRow(String label, int value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
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
          child: Text('Home'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkBlue,
            foregroundColor: AppColors.mistyRose,
          ),
          onPressed: () {
            // Navigate back to home
            Navigator.pushNamed(context, AppRoutes.home);
            Provider.of<LessonProvider>(context, listen: false).resetLesson();
          },
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.lessonScreen);
            Provider.of<LessonProvider>(context, listen: false).resetLesson();
          },
          child: Text('Retry Lesson'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lightBlue,
            foregroundColor: AppColors.bgWhite,
          ),
        ),
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
