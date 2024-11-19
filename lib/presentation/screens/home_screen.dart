import 'package:changma_bhach/presentation/screens/flashcard/flashcard_screen.dart';
import 'package:changma_bhach/presentation/screens/lessons/lesson_screen.dart';
import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/app_images.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/presentation/widgets/lesson_button.dart';
import 'package:changma_bhach/presentation/widgets/proverb_carousal.dart';
import 'package:changma_bhach/presentation/widgets/score_counter.dart';
import 'package:changma_bhach/presentation/widgets/settings_dialog.dart';
import 'package:changma_bhach/providers/lesson_provider.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.backgroundColor,
          leading: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SettingsDialog(),
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.ellipsisVertical,
                size: 30,
              )),
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
              const SizedBox(
                height: 20,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       "Let's learn",
              //       style: TextStyles.subHeadingText
              //           .copyWith(fontSize: 32, color: AppColors.dark),
              //     ),
              //     Text("Something interesting",
              //         style: TextStyles.headingText
              //             .copyWith(fontSize: 32, color: AppColors.primary)),
              //   ],
              // ),
              Text(
                AppLocalizations.of(context)!.proverbTitle,
                style: TextStyles.categoryHeading
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              const ProverbCarousal(),

              const SizedBox(
                height: 40,
              ),
              Text(
                AppLocalizations.of(context)!.lesson,
                style: TextStyles.categoryHeading
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Row(
                  children: [
                    Column(
                      children: [
                        LessonButton(
                          bgColor: AppColors.tertiaryLight,
                          headingText: AppLocalizations.of(context)!.vowel,
                          subHeadingText:
                              AppLocalizations.of(context)!.vowelChakma,
                          textColor: AppColors.tertiaryDarkDark,
                          height: 0.18,
                          bgImage: AppImages.vowelImage,
                          isCompleted: Provider.of<LessonProvider>(context)
                              .isLessonCompleted(LessonType.vowel),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LessonScreen(
                                        selectedLessonType: LessonType.vowel,
                                      )),
                            );

                            Provider.of<LessonProvider>(context, listen: false)
                                .resetLesson();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LessonButton(
                          bgColor: AppColors.quaternaryLight,
                          headingText: AppLocalizations.of(context)!.diacritics,
                          subHeadingText:
                              AppLocalizations.of(context)!.diacriticsChakma,
                          textColor: AppColors.quaternaryDarkDark,
                          height: 0.2,
                          bgImage: AppImages.diacriticImage,
                          isCompleted: Provider.of<LessonProvider>(context)
                              .isLessonCompleted(LessonType.diacritics),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LessonScreen(
                                          selectedLessonType:
                                              LessonType.diacritics,
                                        )));
                            Provider.of<LessonProvider>(context, listen: false)
                                .resetLesson();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        LessonButton(
                          bgColor: AppColors.secondaryLight,
                          headingText: AppLocalizations.of(context)!.consonant,
                          subHeadingText:
                              AppLocalizations.of(context)!.consonantChakma,
                          textColor: AppColors.secondaryDarkDark,
                          height: 0.2,
                          bgImage: AppImages.consonantImage,
                          onTap: () {
                            showConsonantDialog(context);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LessonButton(
                          bgColor: AppColors.quinaryLight,
                          headingText: AppLocalizations.of(context)!.numerals,
                          subHeadingText:
                              AppLocalizations.of(context)!.numeralsChakma,
                          textColor: AppColors.quinaryDarkDark,
                          height: 0.18,
                          bgImage: AppImages.numberImage,
                          isCompleted: Provider.of<LessonProvider>(context)
                              .isLessonCompleted(LessonType.numbers),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LessonScreen(
                                          selectedLessonType:
                                              LessonType.numbers,
                                        )));
                            Provider.of<LessonProvider>(context, listen: false)
                                .resetLesson();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                AppLocalizations.of(context)!.proverbTitle,
                style: TextStyles.categoryHeading
                    .copyWith(fontWeight: FontWeight.normal),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FlashCardScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.tertiaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.card_giftcard,
                                size: 32,
                                color: AppColors.tertiaryDarkDark,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Flash Cards",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.tertiaryDarkDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Practice with flash cards",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.tertiaryDarkDark,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.alphabetTable);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.grid_view_rounded,
                                size: 32,
                                color: AppColors.secondaryDarkDark,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Alphabet Table",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondaryDarkDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "View all Chakma letters",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.secondaryDarkDark,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showConsonantDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        backgroundColor: AppColors.backgroundColor,
        contentPadding: const EdgeInsets.all(20),
        shadowColor: AppColors.secondary,
        children: [
          LessonButton(
            bgColor: AppColors.secondaryLight,
            // lessonIconText: "𑄷-𑄿",
            headingText: AppLocalizations.of(context)!.consonant,
            subHeadingText: AppLocalizations.of(context)!.consonantChakma,
            textColor: AppColors.secondaryDarkDark,
            height: 0.16,
            bgImage: AppImages.consonantImage1,
            isCompleted: Provider.of<LessonProvider>(context)
                .isLessonCompleted(LessonType.consonant1),
            onTap: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LessonScreen(
                            selectedLessonType: LessonType.consonant1,
                          )));
              Provider.of<LessonProvider>(context, listen: false).resetLesson();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          LessonButton(
            bgColor: AppColors.tertiaryLight,
            // lessonIconText: "𑄏-𑄖",
            headingText: AppLocalizations.of(context)!.consonant,
            subHeadingText: AppLocalizations.of(context)!.consonantChakma,
            textColor: AppColors.tertiaryDarkDark,
            height: 0.16,
            bgImage: AppImages.consonantImage2,
            isCompleted: Provider.of<LessonProvider>(context)
                .isLessonCompleted(LessonType.consonant2),
            onTap: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LessonScreen(
                            selectedLessonType: LessonType.consonant2,
                          )));
              Provider.of<LessonProvider>(context, listen: false).resetLesson();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          LessonButton(
            bgColor: AppColors.quaternaryLight,
            // lessonIconText: "𑄗-𑄞",
            headingText: AppLocalizations.of(context)!.consonant,
            subHeadingText: AppLocalizations.of(context)!.consonantChakma,
            textColor: AppColors.quaternaryDarkDark,
            height: 0.16,
            bgImage: AppImages.consonantImage3,
            isCompleted: Provider.of<LessonProvider>(context)
                .isLessonCompleted(LessonType.consonant3),
            onTap: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LessonScreen(
                            selectedLessonType: LessonType.consonant3,
                          )));
              Provider.of<LessonProvider>(context, listen: false).resetLesson();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          LessonButton(
            bgColor: AppColors.tertiaryLight,
            // lessonIconText: "𑄟-𑄦",
            headingText: AppLocalizations.of(context)!.consonant,
            subHeadingText: AppLocalizations.of(context)!.consonantChakma,
            textColor: AppColors.tertiaryDarkDark,
            height: 0.16,
            bgImage: AppImages.consonantImage4,
            isCompleted: Provider.of<LessonProvider>(context)
                .isLessonCompleted(LessonType.consonant4),
            onTap: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LessonScreen(
                            selectedLessonType: LessonType.consonant3,
                          )));
              Provider.of<LessonProvider>(context, listen: false).resetLesson();
            },
          ),
        ],
      );
    },
  );
}
