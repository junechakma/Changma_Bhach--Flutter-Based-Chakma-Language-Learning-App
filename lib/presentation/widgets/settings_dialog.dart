import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/presentation/screens/about_us_screen.dart';
import 'package:changma_bhach/presentation/screens/credits_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:changma_bhach/providers/locale_provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: AppColors.backgroundColor,
      contentPadding: const EdgeInsets.all(20),
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(
                  FontAwesomeIcons.language,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 10,),
                Text(
                  AppLocalizations.of(context)!.selectLanguage,
                  style:
                      TextStyles.headingText.copyWith(color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DropdownButton(
              style: const TextStyle(color: Colors.black),
              dropdownColor: AppColors.backgroundColor,
              underline: Container(
                height: 2,
                color: AppColors.primary,
              ),
              items: const [
                DropdownMenuItem(
                  value: Locale("en"),
                  child: Text("English"),
                ),
                DropdownMenuItem(
                  value: Locale("bn"),
                  child: Text("বাংলা"),
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
            const SizedBox(height: 20),
            // Credits Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreditsScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.primary),
                minimumSize: WidgetStateProperty.all(
                  const Size(double.infinity, 40),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.credits,
                style: TextStyles.buttonText.copyWith(
                  color: AppColors.backgroundColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // About Us Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.primary),
                minimumSize: WidgetStateProperty.all(
                  const Size(double.infinity, 40),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.aboutUs,
                style: TextStyles.buttonText.copyWith(
                  color: AppColors.backgroundColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
