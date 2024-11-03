import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/presentation/widgets/score_counter.dart';
import 'package:changma_bhach/providers/lesson_provider.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatefulWidget {
  final LessonType selectedLessonType;
  const LessonScreen({super.key, required this.selectedLessonType});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LessonProvider>(context, listen: false)
          .setlessonType(widget.selectedLessonType);
    });
  }

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);

    final String appBarTitle = lessonProvider.lessonHeading;
    // final GlobalKey<DrawingWidgetState> _drawingWidgetKey =
    //     GlobalKey<DrawingWidgetState>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        showExitAlert(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        appBar: AppBar(
          backgroundColor: AppColors.bgWhite,
          title: Text(
            appBarTitle == "vowel"
                ? AppLocalizations.of(context)!.vowel
                : AppLocalizations.of(context)!.consonant,
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
          margin: const EdgeInsets.only(top: 20),
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
                              onPressed: () {},
                              icon: const Icon(
                                Icons.volume_up,
                                size: 32,
                              ))
                        ],
                      ),
                      Text(
                        lessonProvider.content["letter"],
                        style:
                            TextStyles.categoryHeading.copyWith(fontSize: 120),
                      ),
                      Text(
                        lessonProvider.content["pronunciation"],
                        style: TextStyles.subHeadingText.copyWith(fontSize: 26),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "শব্দঃ",
                            style: TextStyles.subHeadingText
                                .copyWith(fontSize: 18),
                          ),
                          Text(
                            lessonProvider.content["word"],
                            style: TextStyles.subHeadingText
                                .copyWith(fontSize: 18),
                          ),
                          Text(
                            "-",
                            style: TextStyles.subHeadingText
                                .copyWith(fontSize: 18),
                          ),
                          Text(
                            lessonProvider.content["chakmaWord"],
                            style: TextStyles.subHeadingText
                                .copyWith(fontSize: 18),
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
              Text(
                lessonProvider.content["rules"],
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
                valueColor:
                    const AlwaysStoppedAnimation(AppColors.yellowCrayola),
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
      ),
    );
  }
}

Future showExitAlert(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text('Do you really want to go to home?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.bottomNav);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
