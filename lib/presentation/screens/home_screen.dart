import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/app_images.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/presentation/widgets/lesson_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.bgWhite2,
        actions: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(""),
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
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top App Bar

              const SizedBox(
                height: 20,
              ),

              const Text(
                "Sero Hitte Hala Mege ",
                style: TextStyles.headingText,
              ),
              const Text(
                "Dagijebo jokke Debabu",
                style: TextStyles.subHeadingText,
              ),

              const SizedBox(
                height: 20,
              ),

              const Text(
                "Lessons",
                style: TextStyles.categoryHeading,
              ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.43,
                child: GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    LessonButton(
                      bgColor: AppColors.lightPeriwinkle,
                      image: AppImages.vowelImage,
                      headingText: "Vowel",
                      subHeadingText: "Gaimattyapath",
                    ),
                    LessonButton(
                      bgColor: AppColors.paleRobinEggBlue,
                      image: AppImages.vowelImage,
                      headingText: "Vowel",
                      subHeadingText: "Gaimattyapath",
                    ),
                    LessonButton(
                      bgColor: AppColors.yellowCrayola,
                      image: AppImages.diacriticsImage,
                      headingText: "Vowel",
                      subHeadingText: "Gaimattyapath",
                    ),
                    LessonButton(
                      bgColor: AppColors.skyBlueCrayola,
                      image: AppImages.conjunctImage,
                      headingText: "Vowel",
                      subHeadingText: "Gaimattyapath",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const Text(
                "Practices",
                style: TextStyles.categoryHeading,
              ),

              const SizedBox(
                height: 20,
              ),

              const LessonButton(
                bgColor: AppColors.mistyRose,
                image: AppImages.conjunctImage,
                headingText: "Vowel",
                subHeadingText: "Gaimattyapath",
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
