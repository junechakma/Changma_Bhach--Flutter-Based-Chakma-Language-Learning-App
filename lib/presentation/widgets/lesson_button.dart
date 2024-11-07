import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LessonButton extends StatelessWidget {
  final Color bgColor;
  final String headingText;
  final String subHeadingText;
  final VoidCallback onTap;
  final String lessonIconText;
  final double height;
  final Color textColor;
  final String bgImage;

  const LessonButton(
      {super.key,
      required this.bgColor,
      required this.headingText,
      required this.subHeadingText,
      required this.onTap,
      this.lessonIconText = "𑄇-𑄎",
      required this.height,
      required this.textColor,
      required this.bgImage});

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: cardWidth.width * .42,
        height: cardWidth.height * height,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor,
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("$headingText $lessonIconText",
                        style:
                            TextStyles.headingText.copyWith(color: textColor)),
                  ],
                ),
                Text(subHeadingText,
                    style:
                        TextStyles.subHeadingText.copyWith(color: textColor)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: FaIcon(
                        FontAwesomeIcons.play,
                        color: textColor,
                        size: 16,
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
