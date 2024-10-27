import 'package:flutter/material.dart';

class LessonProvider extends ChangeNotifier {
  bool _isDrawMode = false;
  int _currentIndex = 0;
  bool _isCorrectLetter = false;

  final List<Map<String, dynamic>> _vowels = [
    {
      'letter': '𑄈',
      'pronunciation': 'গুজঙ্যা-খা',
      'word': 'অনারস',
      'chakmaWord': 'আনাজ (𑄥𑄕𑄎𑄧)',
      'rules': 'চাকমা ভাষায় স্বরবর্ন মাত্র ১টি (পিচপুঝা-আ)।'
    },
    {
      'letter': '𑄢',
      'pronunciation': 'পিছপুজা-ই',
      'word': 'ইলিশ',
      'chakmaWord': 'ইলিশ (𑄇𑄧𑄟𑄧)',
      'rules': 'চাকমা ভাষায় স্বরবর্ন মাত্র ১টি (পিচপুঝা-ই)।'
    },
    {
      'letter': '𑄘',
      'pronunciation': 'পিছপুজা-উ',
      'word': 'উদ্ভিদ',
      'chakmaWord': 'উদ্ভিদ (𑄇𑄧𑄖𑄧𑄚)',
      'rules': 'চাকমা ভাষায় স্বরবর্ন মাত্র ১টি (পিচপুঝা-উ)।'
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
  Map<String, dynamic> get content => _vowels[_currentIndex];

  void toggleIsDrawMode() {
    _isDrawMode = !_isDrawMode;
    notifyListeners();
  }

  void drawingValidation(String letter) {
    if (_vowels[currentIndex]["letter"] == letter) {
      _isCorrectLetter = true;
      notifyListeners();
    } else {
      _isCorrectLetter = false;
    }
  }

  void nextLetter() {
    if (_isCorrectLetter && _currentIndex < _vowels.length - 1) {
      _currentIndex++;
      _isCorrectLetter = false;
      notifyListeners();
    }
  }
}
