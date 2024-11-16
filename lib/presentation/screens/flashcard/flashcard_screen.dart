import 'package:changma_bhach/data/flashcard_words.dart';
import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FlashCardScreen extends StatefulWidget {
  @override
  _FlashCardScreenState createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen> {
  final List<Map<String, String>> words = FlashCardWords.words;
  final PageController _pageController = PageController();
  final Map<int, bool> _flippedStates = {};
  int _currentPage = 0;
  final List<Color> _colorOptions = [
    AppColors.secondaryLight,
    AppColors.tertiaryLight,
    AppColors.quaternaryLight,
    AppColors.quinaryLight,
  ];

  Color _getColorForIndex(int index) {
    return _colorOptions[index % _colorOptions.length];
  }

  Color _getTextColorForBackground(Color backgroundColor) {
    if (backgroundColor == AppColors.secondaryLight) {
      return AppColors.secondaryDarkDark;
    } else if (backgroundColor == AppColors.tertiaryLight) {
      return AppColors.tertiaryDarkDark;
    } else if (backgroundColor == AppColors.quaternaryLight) {
      return AppColors.quaternaryDarkDark;
    } else {
      return AppColors.quinaryDarkDark;
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < words.length; i++) {
      _flippedStates[i] = false;
    }
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentPage) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  void _flipCard(int index) {
    setState(() {
      _flippedStates[index] = !_flippedStates[index]!;
    });
  }

  Widget _buildProgressBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Card ${_currentPage + 1} of ${words.length}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: ((_currentPage + 1) / words.length),
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getColorForIndex(_currentPage),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flash Cards'),
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: words.length,
              itemBuilder: (context, index) {
                final word = words[index];
                final cardColor = _getColorForIndex(index);
                final textColor = _getTextColorForBackground(cardColor);

                return GestureDetector(
                  onTap: () => _flipCard(index),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TweenAnimationBuilder(
                        tween: Tween<double>(
                          begin: 0,
                          end: _flippedStates[index]! ? 180 : 0,
                        ),
                        duration: Duration(milliseconds: 500),
                        builder: (context, double value, child) {
                          var content = value >= 90
                              ? _buildBackCard(word, cardColor, textColor)
                              : _buildFrontCard(word, cardColor, textColor);
                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY((value * pi) / 180),
                            child: content,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrontCard(
      Map<String, String> word, Color cardColor, Color textColor) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      child: Container(
        width: 300,
        height: 400,
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            word['chakma_script']!,
            style: TextStyle(
              fontSize: 48,
              fontFamily: 'Chakma',
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackCard(
      Map<String, String> word, Color cardColor, Color textColor) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Container(
          width: 300,
          height: 400,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                word['chakma']!,
                style: TextStyle(
                  fontSize: 24,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                word['bangla']!,
                style: TextStyle(
                  fontSize: 24,
                  color: textColor,
                ),
              ),
              SizedBox(height: 20),
              Text(
                word['english']!,
                style: TextStyle(
                  fontSize: 24,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
