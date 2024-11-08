import 'package:changma_bhach/presentation/screens/lessons/lesson_screen.dart';
import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/app_images.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/presentation/widgets/lesson_button.dart';
import 'package:changma_bhach/presentation/widgets/proverb_carousal.dart';
import 'package:changma_bhach/presentation/widgets/score_counter.dart';
import 'package:changma_bhach/providers/lesson_provider.dart';
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
              onPressed: () {},
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
                          lessonIconText: "",
                          headingText: AppLocalizations.of(context)!.vowel,
                          subHeadingText:
                              AppLocalizations.of(context)!.vowelChakma,
                          textColor: AppColors.tertiaryDarkDark,
                          height: 0.18,
                          bgImage: AppImages.vowelImage,
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
                          lessonIconText: "",
                          headingText: AppLocalizations.of(context)!.diacritics,
                          subHeadingText:
                              AppLocalizations.of(context)!.diacriticsChakma,
                          textColor: AppColors.quaternaryDarkDark,
                          height: 0.2,
                          bgImage: AppImages.diacriticImage,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LessonScreen(
                                          selectedLessonType:
                                              LessonType.consonant2,
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
                          lessonIconText: "",
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
                          bgColor: AppColors.tertiaryLight,
                          lessonIconText: "",
                          headingText: AppLocalizations.of(context)!.numerals,
                          subHeadingText:
                              AppLocalizations.of(context)!.numeralsChakma,
                          textColor: AppColors.tertiaryDarkDark,
                          height: 0.18,
                          bgImage: AppImages.numberImage,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LessonScreen(
                                          selectedLessonType:
                                              LessonType.consonant3,
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
                height: 60,
              ),
              Text(
                AppLocalizations.of(context)!.proverbTitle,
                style: TextStyles.categoryHeading
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              const ProverbCarousal(),
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
            lessonIconText: "𑄷-𑄿",
            headingText: AppLocalizations.of(context)!.consonant,
            subHeadingText: AppLocalizations.of(context)!.consonantChakma,
            textColor: AppColors.secondaryDarkDark,
            height: 0.16,
            bgImage: AppImages.consonantImage1,
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
            lessonIconText: "𑄏-𑄖",
            headingText: AppLocalizations.of(context)!.consonant,
            subHeadingText: AppLocalizations.of(context)!.consonantChakma,
            textColor: AppColors.tertiaryDarkDark,
            height: 0.16,
            bgImage: AppImages.consonantImage2,
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
            lessonIconText: "𑄗-𑄞",
            headingText: AppLocalizations.of(context)!.consonant,
            subHeadingText: AppLocalizations.of(context)!.consonantChakma,
            textColor: AppColors.quaternaryDarkDark,
            height: 0.16,
            bgImage: AppImages.consonantImage3,
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
            lessonIconText: "𑄟-𑄦",
            headingText: AppLocalizations.of(context)!.consonant,
            subHeadingText: AppLocalizations.of(context)!.consonantChakma,
            textColor: AppColors.tertiaryDarkDark,
            height: 0.16,
            bgImage: AppImages.consonantImage4,
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
