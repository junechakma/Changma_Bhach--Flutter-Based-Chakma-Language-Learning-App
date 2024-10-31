import 'package:changma_bhach/providers/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LessonType { vowel, consonant }

class LessonProvider extends ChangeNotifier {
  bool _isDrawMode = false;
  int _currentIndex = 0;
  bool _isCorrectLetter = false;
  bool _lastLetter = false;
  LessonType currentLessonType = LessonType.vowel;
  List<Map<String, dynamic>> _selectedLesson = [];

  final List<Map<String, dynamic>> _vowels = [
    {
      'letter': '𑄃',
      'pronunciation': 'পিছপুজা-আ',
      'word': 'আনারস',
      'chakmaWord': 'আনাজ (𑄥𑄕𑄎𑄧)',
      'rules': 'চাকমা ভাষায় স্বরবর্ন মাত্র ১টি (পিচপুঝা-আ)।'
    },
    {
      'letter': '𑄚',
      'pronunciation': 'পিছপুজা-এ',
      'word': 'এলাচি',
      'chakmaWord': 'এলাচি (𑄇𑄧𑄟𑄧)',
      'rules': 'চাকমা ভাষায় স্বরবর্ন মাত্র ১টি (পিচপুঝা-এ)।'
    }
  ];

  final List<Map<String, dynamic>> _consonants = [
    {
      'letter': '𑄚',
      'pronunciation': 'পিছপুজা-আ',
      'word': 'আনারস',
      'chakmaWord': 'আনাজ (𑄥𑄕𑄎𑄧)',
      'rules': 'চাকমা ভাষায় স্বরবর্ন মাত্র ১টি (পিচপুঝা-আ)।'
    },
    {
      'letter': '𑄚',
      'pronunciation': 'পিছপুজা-এ',
      'word': 'এলাচি',
      'chakmaWord': 'এলাচি (𑄇𑄧𑄟𑄧)',
      'rules': 'চাকমা ভাষায় স্বরবর্ন মাত্র ১টি (পিচপুঝা-এ)।'
    }
  ];

  bool get isDrawMode => _isDrawMode;
  int get currentIndex => _currentIndex;
  bool get isCorrectLetter => _isCorrectLetter;
  Map<String, dynamic> get content => _selectedLesson[_currentIndex];
  bool get lastLetter => _lastLetter;
  double get lessonProgress => _currentIndex + 1 / _selectedLesson.length;

  void setlessonType(LessonType type) {
    currentLessonType = type;
    _selectedLesson =
        (currentLessonType == LessonType.vowel) ? _vowels : _consonants;
  }

  void toggleIsDrawMode() {
    _isDrawMode = !_isDrawMode;
    notifyListeners();
  }

  void drawingValidation(BuildContext context, String letter) {
    if (_selectedLesson[currentIndex]["letter"] == letter) {
      _isCorrectLetter = true;

      Provider.of<ScoreProvider>(context, listen: false).incrementScore();

      notifyListeners();
      if (_isCorrectLetter && _currentIndex == _vowels.length - 1) {
        _lastLetter = true;

        notifyListeners();
      }
    } else {
      _isCorrectLetter = false;
    }
  }

  void nextLetter() {
    if (_isCorrectLetter && _currentIndex < _vowels.length - 1) {
      _currentIndex++;
      _isCorrectLetter = false;
      _lastLetter = false;
      notifyListeners();
    }
  }
}
