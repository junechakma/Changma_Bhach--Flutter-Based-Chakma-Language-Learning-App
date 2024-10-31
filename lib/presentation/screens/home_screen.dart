import 'package:changma_bhach/presentation/screens/lessons/lesson_screen.dart';
import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/app_images.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/presentation/widgets/lesson_button.dart';
import 'package:changma_bhach/presentation/widgets/proverb_carousal.dart';
import 'package:changma_bhach/presentation/widgets/score_counter.dart';
import 'package:changma_bhach/providers/lesson_provider.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            ScoreCounter(),
            SizedBox(
              width: 20,
            )
          ]),
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

              // Proverb Section
              Text(
                AppLocalizations.of(context)!.proverbTitle,
                style: TextStyles.categoryHeading,
              ),

              const ProverbCarousal(),
              const SizedBox(
                height: 40,
              ),

              Text(
                AppLocalizations.of(context)!.lesson,
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
                  children: [
                    LessonButton(
                      bgColor: AppColors.lightPeriwinkle,
                      image: AppImages.vowelImage,
                      headingText: AppLocalizations.of(context)!.vowel,
                      subHeadingText: AppLocalizations.of(context)!.vowelChakma,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LessonScreen(
                                      selectedLessonType: LessonType.vowel,
                                    )));
                      },
                    ),
                    LessonButton(
                      bgColor: AppColors.paleRobinEggBlue,
                      image: AppImages.consonantImage,
                      headingText: AppLocalizations.of(context)!.consonant,
                      subHeadingText:
                          AppLocalizations.of(context)!.consonantChakma,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LessonScreen(
                                      selectedLessonType: LessonType.consonant,
                                    )));
                      },
                    ),
                    LessonButton(
                      bgColor: AppColors.yellowCrayola,
                      image: AppImages.diacriticsImage,
                      headingText: AppLocalizations.of(context)!.diacritics,
                      subHeadingText:
                          AppLocalizations.of(context)!.diacriticsChakma,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LessonScreen(
                                      selectedLessonType: LessonType.vowel,
                                    )));
                      },
                    ),
                    LessonButton(
                      bgColor: AppColors.skyBlueCrayola,
                      image: AppImages.conjunctImage,
                      headingText: AppLocalizations.of(context)!.numerals,
                      subHeadingText:
                          AppLocalizations.of(context)!.numeralsChakma,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LessonScreen(
                                      selectedLessonType: LessonType.consonant,
                                    )));
                      },
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

              LessonButton(
                bgColor: AppColors.mistyRose,
                image: AppImages.conjunctImage,
                headingText: "Vowel",
                subHeadingText: "Gaimattyapath",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.lessonScreen);
                },
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
