import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math';

class Proverbs extends StatelessWidget {
  const Proverbs({super.key});

  // Get a random positive proverb
  static String getRandomPositiveProverb(BuildContext context) {
    final List<String> positiveProverbs = [
      AppLocalizations.of(context)!.proverb1,
      AppLocalizations.of(context)!.proverb2,
      AppLocalizations.of(context)!.proverb3,
      AppLocalizations.of(context)!.proverb4,
      AppLocalizations.of(context)!.proverb5,
      AppLocalizations.of(context)!.proverb6,
      AppLocalizations.of(context)!.proverb7,
      AppLocalizations.of(context)!.proverb8,
      AppLocalizations.of(context)!.proverb9,
      AppLocalizations.of(context)!.proverb10,
      AppLocalizations.of(context)!.proverb11,
      AppLocalizations.of(context)!.proverb12,
      AppLocalizations.of(context)!.proverb13,
      AppLocalizations.of(context)!.proverb14,
      AppLocalizations.of(context)!.proverb15,
      AppLocalizations.of(context)!.proverb16,
    ];
    final random = Random();
    return positiveProverbs[random.nextInt(positiveProverbs.length)];
  }

  // Get a random negative proverb
  static String getRandomNegativeProverb(BuildContext context) {
    final List<String> negativeProverbs = [
      AppLocalizations.of(context)!.proverb17,
      AppLocalizations.of(context)!.proverb18,
      AppLocalizations.of(context)!.proverb19,
      AppLocalizations.of(context)!.proverb20,
      AppLocalizations.of(context)!.proverb21,
      AppLocalizations.of(context)!.proverb22,
      AppLocalizations.of(context)!.proverb23,
      AppLocalizations.of(context)!.proverb24,
      AppLocalizations.of(context)!.proverb25,
      AppLocalizations.of(context)!.proverb26,
      AppLocalizations.of(context)!.proverb27,
      AppLocalizations.of(context)!.proverb28,
      AppLocalizations.of(context)!.proverb29,
      AppLocalizations.of(context)!.proverb30,
      AppLocalizations.of(context)!.proverb31,
      AppLocalizations.of(context)!.proverb32,
      AppLocalizations.of(context)!.proverb33,
      AppLocalizations.of(context)!.proverb34,
    ];
    final random = Random();
    return negativeProverbs[random.nextInt(negativeProverbs.length)];
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
