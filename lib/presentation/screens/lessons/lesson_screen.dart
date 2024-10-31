import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/presentation/widgets/score_counter.dart';
import 'package:changma_bhach/providers/lesson_provider.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatelessWidget {
  final LessonType selectedLessonType;
  const LessonScreen({super.key, required this.selectedLessonType});

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);
    lessonProvider.setlessonType(selectedLessonType);
    // final GlobalKey<DrawingWidgetState> _drawingWidgetKey =
    //     GlobalKey<DrawingWidgetState>();

    void onPressed() {}
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        title: Text(
          AppLocalizations.of(context)!.vowel,
          style: TextStyles.lessonText.copyWith(fontSize: 26),
        ),
        centerTitle: true,
        actions: const [
          ScoreCounter(),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 400,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.lessonBg),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: onPressed,
                            icon: const Icon(
                              Icons.volume_up,
                              size: 32,
                            ))
                      ],
                    ),
                    Text(
                      lessonProvider.content["letter"],
                      style: TextStyles.categoryHeading.copyWith(fontSize: 120),
                    ),
                    Text(
                      lessonProvider.content["pronunciation"],
                      style: TextStyles.subHeadingText.copyWith(fontSize: 28),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "শব্দঃ",
                          style: TextStyles.subHeadingText,
                        ),
                        Text(
                          lessonProvider.content["word"],
                          style: TextStyles.subHeadingText,
                        ),
                        const Text(
                          "-",
                          style: TextStyles.subHeadingText,
                        ),
                        Text(
                          lessonProvider.content["chakmaWord"],
                          style: TextStyles.subHeadingText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "চাকমা ভাষায় স্বরবর্ন মাত্র ১টি (পিচপুঝা-আ)।",
              style: TextStyles.lessonText,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(""),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.drawingScreen);
                  },
                  child: const Row(
                    children: [
                      Text("আকুন"),
                      Icon(Icons.brush)
                    ], // Removed `Flexible`
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            LinearProgressIndicator(
              value: lessonProvider.lessonProgress,
              valueColor: const AlwaysStoppedAnimation(AppColors.yellowCrayola),
              backgroundColor: AppColors.darkBlue,
              borderRadius: BorderRadius.circular(8),
              minHeight: 10,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
