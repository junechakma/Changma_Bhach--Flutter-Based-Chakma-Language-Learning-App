import 'package:changma_bhach/data/content.dart';
import 'package:changma_bhach/providers/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LessonType { vowel, consonant }

class LessonProvider extends ChangeNotifier {
  int _wrongAnswers = 0;
  int _correctAnswers = 0;
  int _currentIndex = 0;
  bool _isCorrectLetter = false;
  bool _lastLetter = false;

  LessonType _currentLessonType = LessonType.vowel;
  List<Map<String, dynamic>> _selectedLesson = [];

  int get currentIndex => _currentIndex;
  bool get isCorrectLetter => _isCorrectLetter;
  Map<String, dynamic> get content =>
      _selectedLesson.isNotEmpty ? _selectedLesson[_currentIndex] : {};
  bool get lastLetter => _lastLetter;

  double get lessonProgress {
    return _selectedLesson.isNotEmpty
        ? (_currentIndex + 1) / _selectedLesson.length
        : 0.0;
  }

  int get lessonWrongAnswer => _wrongAnswers;
  int get lessonCorrectAnswer => _correctAnswers;
  LessonType get currentLessonType => _currentLessonType;

  void setlessonType(LessonType type) {
    _currentLessonType = type;
    _selectedLesson = (_currentLessonType == LessonType.vowel)
        ? Content.vowels
        : Content.consonants;
    notifyListeners();
  }

  void resetLesson() {
    _currentIndex = 0;
    _wrongAnswers = 0;
    _isCorrectLetter = false;
    _lastLetter = false;
    _isCorrectLetter = false;
    _lastLetter = false;
    notifyListeners();
  }

  void drawingValidation(BuildContext context, String letter) {
    if (_selectedLesson.isEmpty) return;

    if (_selectedLesson[currentIndex]["letter"] == letter) {
      _isCorrectLetter = true;

      // Safely access ScoreProvider
      try {
        Provider.of<ScoreProvider>(context, listen: false).incrementScore();
        _correctAnswers++;
      } catch (e) {
        print('Error incrementing score: $e');
      }

      // Check if this is the last letter
      if (_currentIndex == _selectedLesson.length - 1) {
        _lastLetter = true;
      }

      notifyListeners();
    } else {
      _isCorrectLetter = false;
      _wrongAnswers++;
      notifyListeners();
    }
  }

  void nextLetter() {
    if (_selectedLesson.isEmpty) return;

    if (_isCorrectLetter && _currentIndex < _selectedLesson.length - 1) {
      _currentIndex++;
      _isCorrectLetter = false;

      // Reset last letter flag if not on the final letter
      if (_currentIndex < _selectedLesson.length - 1) {
        _lastLetter = false;
      }

      notifyListeners();
    }
  }
}
