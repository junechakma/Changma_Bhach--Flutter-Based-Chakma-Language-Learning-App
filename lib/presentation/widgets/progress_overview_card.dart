import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';

class ProgressOverviewCard extends StatelessWidget {
  const ProgressOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Progress',
            style: TextStyles.subHeadingText.copyWith(
              color: AppColors.dark,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProgressIndicator(
                label: 'Vowels',
                progress: 0.75,
                color: AppColors.tertiaryDark,
              ),
              _buildProgressIndicator(
                label: 'Consonants',
                progress: 0.45,
                color: AppColors.secondaryDark,
              ),
              _buildProgressIndicator(
                label: 'Numbers',
                progress: 0.30,
                color: AppColors.quinaryDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator({
    required String label,
    required double progress,
    required Color color,
  }) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 30.0,
          lineWidth: 5.0,
          percent: progress,
          center: Text(
            '${(progress * 100).round()}%',
            style: TextStyles.subHeadingText.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          progressColor: color,
          backgroundColor: color.withOpacity(0.2),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyles.subHeadingText.copyWith(
            fontSize: 12,
            color: AppColors.dark,
          ),
        ),
      ],
    );
  }
}
