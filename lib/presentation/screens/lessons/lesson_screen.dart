import 'package:audioplayers/audioplayers.dart';
import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/presentation/widgets/score_counter.dart';
import 'package:changma_bhach/providers/lesson_provider.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:changma_bhach/presentation/widgets/exit_alert.dart';

class LessonScreen extends StatefulWidget {
  final LessonType selectedLessonType;
  const LessonScreen({super.key, required this.selectedLessonType});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isAudioInitialized = false;

  @override
  void initState() {
    super.initState();
    _initAudio();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LessonProvider>(context, listen: false)
          .setlessonType(context, widget.selectedLessonType);
    });
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer
          .setSource(AssetSource('audios/congratulations.mp3')); // Test audio
      _isAudioInitialized = true;
    } catch (e) {
      print("Error initializing audio: $e");
      _isAudioInitialized = false;
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String? audioPath) async {
    if (!_isAudioInitialized) {
      print("Audio player not initialized");
      return;
    }

    if (audioPath == null || audioPath.isEmpty) {
      print("Audio path is empty or null");
      return;
    }

    try {
      // Normalize the audio path
      String normalizedPath = audioPath.startsWith('assets/')
          ? audioPath.substring(7)
          : audioPath.startsWith('/')
              ? audioPath.substring(1)
              : audioPath;

      await _audioPlayer.stop(); // Stop any currently playing audio
      await _audioPlayer.setSource(AssetSource(normalizedPath));
      await _audioPlayer.resume();
    } catch (e) {
      print("Error playing audio: $e");
      // You might want to show a snackbar or some UI feedback here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to play audio: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);

    final String appBarTitle = lessonProvider.lessonHeading;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        ExitAlert.show(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: Text(
            appBarTitle == "vowel"
                ? AppLocalizations.of(context)!.vowel
                : appBarTitle == "diacritics"
                    ? AppLocalizations.of(context)!.diacritics
                    : appBarTitle == "numbers"
                        ? AppLocalizations.of(context)!.numerals
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
                              onPressed: () {
                                final audioPath =
                                    lessonProvider.content['audio'] as String?;
                                _playAudio('audios/congratulations.mp3');
                              },
                              icon: const Icon(
                                Icons.volume_up,
                                size: 32,
                              ))
                        ],
                      ),
                      Text(
                        lessonProvider.content["letter"] ?? '',
                        style:
                            TextStyles.categoryHeading.copyWith(fontSize: 120),
                      ),
                      Text(
                        lessonProvider.content["pronunciation"] ?? '',
                        style: TextStyles.subHeadingText
                            .copyWith(fontSize: 26, color: AppColors.primary),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "শব্দঃ",
                            style: TextStyles.subHeadingText.copyWith(
                                fontSize: 18, color: AppColors.primary),
                          ),
                          const Text(
                            " ",
                          ),
                          Text(
                            lessonProvider.content["word"] ?? '',
                            style: TextStyles.subHeadingText.copyWith(
                                fontSize: 18, color: AppColors.darkLight),
                          ),
                          Text(
                            " >> ",
                            style: TextStyles.subHeadingText.copyWith(
                                fontSize: 18, color: AppColors.darkLight),
                          ),
                          Text(
                            lessonProvider.content["chakmaWord"] ?? '',
                            style: TextStyles.subHeadingText.copyWith(
                                fontSize: 18, color: AppColors.darkLight),
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
                lessonProvider.content["rules"] ?? '',
                style:
                    TextStyles.lessonText.copyWith(color: AppColors.darkLight),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.drawingScreen);
                    },
                    style: ButtonStyle(
                        foregroundColor:
                            WidgetStateProperty.all(AppColors.backgroundColor),
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.primary)),
                    child: Row(
                      children: [
                        Text(AppLocalizations.of(context)!.draw_button),
                        const FaIcon(FontAwesomeIcons.paintbrush)
                      ], // Removed `Flexible`
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              LinearProgressIndicator(
                value: lessonProvider.lessonProgress,
                valueColor: const AlwaysStoppedAnimation(AppColors.quinaryDark),
                backgroundColor: AppColors.quinaryLight,
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
