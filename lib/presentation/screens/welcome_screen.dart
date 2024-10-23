import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/app_images.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/providers/locale_provider.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:changma_bhach/utils/all_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  logoTextEnglish,
                  style: TextStyles.logoTextStyle,
                ),
                const Row(
                  children: [
                    Text(
                      logoTextBangla,
                      style: TextStyles.logoTextStyle,
                    ),
                    Text(
                      "($logoTextChakma)",
                      style: TextStyles.logoTextStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.welcomeMessage,
                  style:
                      TextStyles.welcomeHeading.copyWith(fontFamily: "Roboto"),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: AppColors.darkBlue,
                  underline: Container(
                    height: 2,
                    color: Colors.white,
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: Locale("en"),
                        child: Text(
                          "English",
                        )),
                    DropdownMenuItem(
                      value: Locale("bn"),
                      child: Text(
                        "বাংলা",
                      ),
                    ),
                  ],
                  onChanged: (newLang) {
                    if (newLang != null) {
                      Provider.of<LocaleProvider>(context, listen: false)
                          .setLocale(newLang);
                    }
                  },
                  value: Provider.of<LocaleProvider>(context).locale,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.bottomNav);
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.apricot),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          AppLocalizations.of(context)!.enter,
                          style: const TextStyle(
                              color: AppColors.darkBlue,
                              fontSize: 18,
                              fontFamily: "Roboto"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.arrow_right_alt_outlined,
                        color: AppColors.darkBlue,
                      )
                    ],
                  ),
                )
              ],
            ),
            const Stack(
              children: [
                Image(
                  image: AssetImage(AppImages.welcomeImage),
                  width: 280,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
