import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/presentation/widgets/lessons/drawing_widget.dart';
import 'package:changma_bhach/presentation/widgets/score_counter.dart';
import 'package:changma_bhach/providers/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);

    final GlobalKey<DrawingWidgetState> _drawingWidgetKey =
        GlobalKey<DrawingWidgetState>();

    void onPressed() {}
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        title: Text(
          AppLocalizations.of(context)!.vowel,
          style: TextStyles.lessonText.copyWith(fontSize: 40),
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
                child: lessonProvider.isDrawMode
                    ? SizedBox(
                        child: ClipRect(
                          child: DrawingWidget(key: _drawingWidgetKey),
                        ),
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: onPressed,
                                  icon: const Icon(
                                    Icons.volume_up,
                                    size: 32,
                                  )),
                              IconButton(
                                  onPressed: () =>
                                      lessonProvider.toggleIsDrawMode(),
                                  icon: const Icon(
                                    Icons.draw,
                                    size: 32,
                                  ))
                            ],
                          ),
                          Text(
                            lessonProvider.content["letter"],
                            style: TextStyles.categoryHeading
                                .copyWith(fontSize: 120),
                          ),
                          Text(
                            lessonProvider.content["pronunciation"],
                            style: TextStyles.subHeadingText
                                .copyWith(fontSize: 28),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              const Text(
                                "শব্দঃ ",
                                style: TextStyles.headingText,
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
            if (!lessonProvider.isDrawMode) ...[
              const Text(
                "চাকমা ভাষায় স্বরবর্ন মাত্র ১টি (পিচপুঝা-আ)।",
                style: TextStyles.lessonText,
              ),
            ] else ...[
              const Text(
                "এত % মিল পাওয়া গেছে",
                style: TextStyles.lessonText,
              )
            ],
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (lessonProvider.isDrawMode) ...[
                  ElevatedButton(
                    onPressed: () => _drawingWidgetKey.currentState?.clear(),
                    child: const Flexible(
                      child: Row(
                        children: [Text("মুছুন"), Icon(Icons.clear_rounded)],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onPressed,
                    child: const Flexible(
                      child: Row(
                        children: [
                          Text("যাচাই করুন"),
                          Icon(Icons.auto_awesome)
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  const Text(""),
                  ElevatedButton(
                    onPressed: lessonProvider.toggleIsDrawMode,
                    child: const Flexible(
                      child: Row(
                        children: [Text("আকুন"), Icon(Icons.brush)],
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
