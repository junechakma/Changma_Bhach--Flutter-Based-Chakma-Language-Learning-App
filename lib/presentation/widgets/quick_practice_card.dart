import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';

class QuickPracticeCard extends StatelessWidget {
  const QuickPracticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Practice',
                    style: TextStyles.subHeadingText.copyWith(
                      color: AppColors.secondaryDark,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Review today\'s lessons',
                    style: TextStyles.subHeadingText.copyWith(
                      color: AppColors.secondaryDark.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondaryDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.play,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPracticeItem(
                icon: FontAwesomeIcons.a,
                label: 'Vowels',
                count: 5,
              ),
              _buildPracticeItem(
                icon: FontAwesomeIcons.b,
                label: 'Consonants',
                count: 8,
              ),
              _buildPracticeItem(
                icon: FontAwesomeIcons.hashtag,
                label: 'Numbers',
                count: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeItem({
    required IconData icon,
    required String label,
    required int count,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.secondaryDark.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: FaIcon(
            icon,
            color: AppColors.secondaryDark,
            size: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyles.subHeadingText.copyWith(
            fontSize: 12,
            color: AppColors.secondaryDark,
          ),
        ),
        Text(
          '$count items',
          style: TextStyles.subHeadingText.copyWith(
            fontSize: 10,
            color: AppColors.secondaryDark.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
