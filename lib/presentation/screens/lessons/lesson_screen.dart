import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:flutter/material.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed() {}
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        title: Text('Lesson Screen'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: onPressed,
                          icon: const Icon(
                            Icons.volume_up,
                            size: 32,
                          )),
                      IconButton(
                          onPressed: onPressed,
                          icon: const Icon(
                            Icons.draw,
                            size: 32,
                          ))
                    ],
                  ),
                  Text(
                    '𑄃',
                    style: TextStyles.categoryHeading.copyWith(fontSize: 120),
                  ),
                  Text(
                    'পিচপুঝা-আ ',
                    style: TextStyles.subHeadingText.copyWith(fontSize: 28),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text(
                        ''' 𑄃 +  𑄧 = 𑄖𑄧 (অ) 
𑄖(আ) উচ্চারণ 𑄖𑄧(অ) এর মত হবে।
''',
                        style: TextStyles.subHeadingText,
                      ),
                    ],
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
