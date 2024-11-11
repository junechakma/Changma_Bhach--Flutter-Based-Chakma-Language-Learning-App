import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/app_images.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/providers/locale_provider.dart';
import 'package:changma_bhach/providers/score_provider.dart'; // Updated import
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScoreCounter extends StatelessWidget {
  const ScoreCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context).locale;
    final numberFormatter =
        NumberFormat.decimalPattern(locale.languageCode == "bn" ? "bn" : "en");

    return InkWell(
      onTap: () {
        final score = Provider.of<ScoreProvider>(context, listen: false).score;
        final formattedScore = numberFormatter.format(score);
        _showScoreDialog(context, formattedScore);
      },
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Consumer<ScoreProvider>(builder: (context, scoreCounter, child) {
            final formattedScore = numberFormatter.format(scoreCounter.score);
            return Text(
              formattedScore.toString(),
              style: TextStyles.scoreCounter,
            );
          }),
          const Image(
            image: AssetImage(AppImages.scoreImage),
            width: 26,
          ),
        ],
      ),
    );
  }
}

void _showScoreDialog(BuildContext context, String formattedScore) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        backgroundColor: AppColors.backgroundColor,
        contentPadding: const EdgeInsets.all(20),
        children: [
          Column(
            children: [
              const Image(
                image: AssetImage(AppImages.bambooshoots),
                width: 250,
              ),
              Text(
                "${AppLocalizations.of(context)!.score_text1} $formattedScore ${AppLocalizations.of(context)!.score_text2}",
                style:
                    TextStyles.headingText.copyWith(color: AppColors.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.bamboo_shoots_text,
                style: TextStyles.lessonText.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      );
    },
  );
}
