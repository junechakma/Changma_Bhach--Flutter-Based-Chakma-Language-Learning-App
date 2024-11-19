import 'package:changma_bhach/data/content_bn.dart';
import 'package:changma_bhach/data/content_en.dart';
import 'package:changma_bhach/providers/locale_provider.dart';
import 'package:changma_bhach/providers/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LessonType {
  vowel,
  consonant1,
  consonant2,
  consonant3,
  consonant4,
  diacritics,
  numbers
}

class LessonProvider extends ChangeNotifier {
  int _wrongAnswers = 0;
  int _correctAnswers = 0;
  int _currentIndex = 0;
  bool _isCorrectLetter = false;
  bool _lastLetter = false;
  String _lessonHeading = "vowel";
  Set<LessonType> _completedLessons = {};
  SharedPreferences? _prefs;

  LessonProvider() {
    _loadCompletedLessons();
  }

  Future<void> _loadCompletedLessons() async {
    _prefs = await SharedPreferences.getInstance();
    final completedLessons = _prefs?.getStringList('completed_lessons') ?? [];
    _completedLessons = completedLessons
        .map(
            (e) => LessonType.values.firstWhere((type) => type.toString() == e))
        .toSet();
    notifyListeners();
  }

  Future<void> _saveCompletedLessons() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setStringList(
      'completed_lessons',
      _completedLessons.map((type) => type.toString()).toList(),
    );
  }

  LessonType _currentLessonType = LessonType.vowel;
  List<Map<String, dynamic>> _selectedLesson = [];

  List<Map<String, dynamic>> _getLocalizedContent(
      BuildContext context, LessonType type) {
    final isEnglish = Provider.of<LocaleProvider>(context, listen: false)
            .locale
            .languageCode ==
        'en';
    switch (type) {
      case LessonType.vowel:
        return isEnglish ? ContentEn.vowel : ContentBn.vowel;
      case LessonType.consonant1:
        return isEnglish ? ContentEn.consonants1 : ContentBn.consonants1;
      case LessonType.consonant2:
        return isEnglish ? ContentEn.consonants2 : ContentBn.consonants2;
      case LessonType.consonant3:
        return isEnglish ? ContentEn.consonants3 : ContentBn.consonants3;
      case LessonType.consonant4:
        return isEnglish ? ContentEn.consonants4 : ContentBn.consonants4;
      case LessonType.diacritics:
        return isEnglish ? ContentEn.diacritics : ContentBn.diacritics;
      case LessonType.numbers:
        return isEnglish ? ContentEn.numbers : ContentBn.numbers;
      default:
        return [];
    }
  }

  void setlessonType(BuildContext context, LessonType type) {
    _currentLessonType = type;
    _currentIndex = 0;
    _wrongAnswers = 0;
    _correctAnswers = 0;
    _isCorrectLetter = false;
    _lastLetter = false;

    switch (type) {
      case LessonType.vowel:
        _lessonHeading = "vowel";
        break;
      case LessonType.consonant1:
      case LessonType.consonant2:
      case LessonType.consonant3:
      case LessonType.consonant4:
        _lessonHeading = "consonant";
        break;
      case LessonType.diacritics:
        _lessonHeading = "diacritics";
        break;
      case LessonType.numbers:
        _lessonHeading = "numbers";
        break;
    }

    _selectedLesson = _getLocalizedContent(context, type);
    notifyListeners();
  }

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
  bool isLessonCompleted(LessonType type) => _completedLessons.contains(type);

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
        _completedLessons.add(_currentLessonType);
        _saveCompletedLessons(); // Save when lesson is completed
      }
      notifyListeners();
    } else {
      _isCorrectLetter = false;
      _wrongAnswers++;
      notifyListeners();
    }
  }

  void resetLesson() {
    _currentIndex = 0;
    _wrongAnswers = 0;
    _correctAnswers = 0;
    _lastLetter = false;
    _isCorrectLetter = false;
    notifyListeners();
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
