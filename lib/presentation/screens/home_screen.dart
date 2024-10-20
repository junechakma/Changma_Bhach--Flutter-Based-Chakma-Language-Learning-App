import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/app_images.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite2,
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Column(
          children: [
            // Top App Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Changma Bhach"),
                SizedBox(
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(AppImages.scoreImage),
                        width: 40,
                      ),
                      Text(
                        "২",
                        style: TextStyles.scoreCounter,
                      )
                    ],
                  ),
                )
              ],
            ),
            Text("Lessons"),
            Row(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
