import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:flutter/material.dart';

class LessonButton extends StatelessWidget {
  final Color bgColor;
  final String headingText;
  final String subHeadingText;
  final VoidCallback onTap;
  final String lessonIconText;

  const LessonButton(
      {super.key,
      required this.bgColor,
      required this.headingText,
      required this.subHeadingText,
      required this.onTap,
      required this.lessonIconText});

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: cardWidth.width * .48,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(lessonIconText,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(headingText, style: TextStyles.headingText),
                Text("($lessonIconText) ", style: TextStyles.headingText),
              ],
            ),
            Text(subHeadingText, style: TextStyles.subHeadingText),
          ],
        ),
      ),
    );
  }
}
