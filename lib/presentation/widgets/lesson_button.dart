import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:flutter/material.dart';

class LessonButton extends StatelessWidget {
  final Color bgColor;
  final String image;
  final String headingText;
  final String subHeadingText;

  const LessonButton(
      {super.key,
      required this.bgColor,
      required this.image,
      required this.headingText,
      required this.subHeadingText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                Image(
                  image: AssetImage(image),
                  width: 100,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(headingText, style: TextStyles.headingText),
            Text(subHeadingText, style: TextStyles.subHeadingText),
          ],
        ),
      ),
    );
  }
}
