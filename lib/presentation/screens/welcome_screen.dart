import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/app_images.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:changma_bhach/utils/all_text.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkBlue,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    logoTextEnglish,
                    style: TextStyles.logoTextStyle,
                  ),
                  const Row(
                    children: [
                      Text(
                        logoTextBangla,
                        style: TextStyles.logoTextStyle,
                      ),
                      Text(
                        "($logoTextChakma)",
                        style: TextStyles.logoTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    welcomeHeading,
                    style: TextStyles.welcomeHeading,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 190,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.bottomNav);
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(AppColors.apricot)),
                      child: const Row(
                        children: [
                          Text(
                            welcomeButtonText,
                            style: TextStyle(
                                color: AppColors.darkBlue, fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_right_alt_outlined,
                            color: AppColors.darkBlue,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Stack(
                children: [
                  Image(
                    image: AssetImage(AppImages.welcomeImage),
                    width: 300,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
