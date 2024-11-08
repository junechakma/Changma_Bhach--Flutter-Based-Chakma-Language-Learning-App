import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProverbCarousal extends StatelessWidget {
  const ProverbCarousal({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> proverbs = [
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

    return CarouselSlider(
      options: CarouselOptions(
        height: 65.0,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 8),
        scrollDirection: Axis.vertical,
      ),
      items: proverbs.map(
        (item) {
          return Builder(
            builder: (BuildContext context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  item,
                  style:
                      const TextStyle(color: AppColors.darkLight, fontSize: 18),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
