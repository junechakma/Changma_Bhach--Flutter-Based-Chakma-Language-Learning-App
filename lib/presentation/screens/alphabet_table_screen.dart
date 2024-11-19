import 'package:flutter/material.dart';
import '../../data/content_en.dart';
import '../../data/content_bn.dart';
import '../../presentation/styles/app_colors.dart';
import '../../providers/locale_provider.dart';
import 'package:provider/provider.dart';

class AlphabetTableScreen extends StatelessWidget {
  const AlphabetTableScreen({super.key});

  List<Map<String, dynamic>> _getLocalizedContent(
      BuildContext context, String contentType) {
    final isEnglish = Provider.of<LocaleProvider>(context, listen: false)
            .locale
            .languageCode ==
        'en';

    switch (contentType) {
      case 'vowel':
        return isEnglish ? ContentEn.vowel : ContentBn.vowel;
      case 'consonants1':
        return isEnglish ? ContentEn.consonants1 : ContentBn.consonants1;
      case 'consonants2':
        return isEnglish ? ContentEn.consonants2 : ContentBn.consonants2;
      case 'consonants3':
        return isEnglish ? ContentEn.consonants3 : ContentBn.consonants3;
      case 'consonants4':
        return isEnglish ? ContentEn.consonants4 : ContentBn.consonants4;
      case 'diacritics':
        return isEnglish ? ContentEn.diacritics : ContentBn.diacritics;
      case 'numbers':
        return isEnglish ? ContentEn.numbers : ContentBn.numbers;
      default:
        return [];
    }
  }

  Widget _buildLetterCard(Map<String, dynamic> letter) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              letter['letter'],
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              letter['pronunciation'],
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String contentType,
      {List<Map<String, dynamic>>? customLetters}) {
    final letters = customLetters ?? _getLocalizedContent(context, contentType);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: letters.length,
          itemBuilder: (context, index) => _buildLetterCard(letters[index]),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Combine all consonants
    final allConsonants = [
      ..._getLocalizedContent(context, 'consonants1'),
      ..._getLocalizedContent(context, 'consonants2'),
      ..._getLocalizedContent(context, 'consonants3'),
      ..._getLocalizedContent(context, 'consonants4'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chakma Alphabets'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(context, 'Vowels', 'vowel'),
            _buildSection(context, 'Consonants', 'consonants',
                customLetters: allConsonants),
            _buildSection(context, 'Diacritics', 'diacritics'),
            _buildSection(context, 'Numbers', 'numbers'),
          ],
        ),
      ),
    );
  }
}
