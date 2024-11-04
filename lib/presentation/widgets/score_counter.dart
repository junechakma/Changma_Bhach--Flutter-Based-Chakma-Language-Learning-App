import 'package:changma_bhach/presentation/styles/app_images.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/providers/locale_provider.dart';
import 'package:changma_bhach/providers/score_provider.dart'; // Updated import
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScoreCounter extends StatelessWidget {
  const ScoreCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context).locale;
    final numberFormatter =
        NumberFormat.decimalPattern(locale.languageCode == "bn" ? "bn" : "en");

    return SizedBox(
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
            width: 30,
          ),
        ],
      ),
    );
  }
}
