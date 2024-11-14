import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "About Us",
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
                "What is Changma Bhach?",
                style: TextStyles.headingText.copyWith(
                  color: AppColors.primary,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Changma Bhach is an educational app designed to help users learn and practice the Chakma language and script. Our mission is to preserve and promote the rich cultural heritage of the Chakma community through accessible digital learning.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 32),
              Text(
                "Our Mission",
                style: TextStyles.headingText.copyWith(
                  color: AppColors.primary,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "• Make Chakma language learning accessible to everyone\n"
                "• Preserve and promote Chakma cultural heritage\n"
                "• Create an engaging and interactive learning experience\n"
                "• Build a community of Chakma language learners",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 32),
              Text(
                "Contact Us",
                style: TextStyles.headingText.copyWith(
                  color: AppColors.primary,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "We'd love to hear from you! If you have any questions, suggestions, or feedback, please reach out to us at:\n\n"
                "Email: contact@changmabhach.com\n"
                "Website: www.changmabhach.com",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
