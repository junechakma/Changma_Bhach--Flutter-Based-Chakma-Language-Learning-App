import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle logoTextStyle = TextStyle(
      fontSize: 28, color: AppColors.apricot, fontWeight: FontWeight.bold);

  static const TextStyle welcomeHeading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static const TextStyle scoreCounter = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 36,
    color: AppColors.dark,
  );

  static const TextStyle categoryHeading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColors.dark,
  );

  static const TextStyle headingText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.dark,
  );
  static const TextStyle subHeadingText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.dark,
  );

  static const TextStyle lessonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.dark,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.dark,
  );
}
