import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "Credits & References",
          style: TextStyles.headingText.copyWith(color: AppColors.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Development Team",
                style: TextStyles.headingText.copyWith(
                  color: AppColors.primary,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "• Project Lead & Developer: [Name]\n"
                "• UI/UX Designer: [Name]\n"
                "• Content Writers: [Names]",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 32),
              Text(
                "Language Resources",
                style: TextStyles.headingText.copyWith(
                  color: AppColors.primary,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Our Chakma language content is based on the following authoritative sources:\n\n"
                "• [Reference Book/Source 1]\n"
                "• [Reference Book/Source 2]\n"
                "• [Reference Book/Source 3]",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 32),
              Text(
                "Special Thanks",
                style: TextStyles.headingText.copyWith(
                  color: AppColors.primary,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "We extend our heartfelt gratitude to:\n\n"
                "• [Organization/Individual 1] - for [contribution]\n"
                "• [Organization/Individual 2] - for [contribution]\n"
                "• The Chakma community for their support and feedback",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 32),
              Text(
                "Open Source Libraries",
                style: TextStyles.headingText.copyWith(
                  color: AppColors.primary,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "This app is built using:\n\n"
                "• Flutter - UI framework by Google\n"
                "• Provider - State management\n"
                "• [Other libraries used]",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
