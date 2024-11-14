import 'package:changma_bhach/data/content.dart';
import 'package:changma_bhach/providers/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LessonType { vowel, consonant1, consonant2, consonant3, consonant4, diacritics, numbers }

class LessonProvider extends ChangeNotifier {
  int _wrongAnswers = 0;
  int _correctAnswers = 0;
  int _currentIndex = 0;
  bool _isCorrectLetter = false;
  bool _lastLetter = false;
  String _lessonHeading = "vowel";

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
  String get lessonHeading => _lessonHeading;

  void setlessonType(LessonType type) {
    _currentLessonType = type;

    switch (type) {
      case LessonType.vowel:
        _selectedLesson = Content.vowel;
        _lessonHeading = "vowel";
        break;

      case LessonType.consonant1:
        _selectedLesson = Content.consonants1;
        _lessonHeading = "consonant";
        break;

      case LessonType.consonant2:
        _selectedLesson = Content.consonants2;
        _lessonHeading = "consonant";
        break;

      case LessonType.consonant3:
        _selectedLesson = Content.consonants3;
        _lessonHeading = "consonant";
        break;

      case LessonType.consonant4:
        _selectedLesson = Content.consonants4;
        _lessonHeading = "consonant";
        break;

      case LessonType.diacritics:
        _selectedLesson = Content.diacritics;
        _lessonHeading = "diacritics";
        break;

      case LessonType.numbers:
        _selectedLesson = Content.numbers;
        _lessonHeading = "numbers";
        break;

      default:
        _selectedLesson = [];
        break;
    }
    notifyListeners();
  }

  void resetLesson() {
    _currentIndex = 0;
    _wrongAnswers = 0;
    _correctAnswers = 0;
    _lastLetter = false;
    _isCorrectLetter = false;
    _lastLetter = false;
    notifyListeners();
  }

  void drawingValidation(BuildContext context, String letter) {
    if (_selectedLesson[currentIndex]["letter"] == letter) {
      _isCorrectLetter = true;
      try {
        Provider.of<ScoreProvider>(context, listen: false).incrementScore();
        _correctAnswers++;
      } catch (e) {
        // print('Error incrementing score: $e');
      }

      if (_currentIndex == _selectedLesson.length - 1) {
        _lastLetter = true;
      }
      notifyListeners();
    } else {
      _isCorrectLetter = false;
      _wrongAnswers++;
      notifyListeners(); // Can trigger rebuild
    }
  }

  void nextLetter() {
    if (_isCorrectLetter && _currentIndex < _selectedLesson.length - 1) {
      _currentIndex++;
      _isCorrectLetter = false;
      if (_currentIndex < _selectedLesson.length - 1) {
        _lastLetter = false;
      }
      notifyListeners();
    }
  }
}
