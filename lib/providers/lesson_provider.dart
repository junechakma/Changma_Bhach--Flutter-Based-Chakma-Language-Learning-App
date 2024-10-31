import 'package:changma_bhach/providers/score_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LessonProvider extends ChangeNotifier {
  bool _isDrawMode = false;
  int _currentIndex = 0;
  bool _isCorrectLetter = false;

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

  final List<Map<String, dynamic>> _consonent = [
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

  bool get isDrawMode => _isDrawMode;
  int get currentIndex => _currentIndex;
  bool get isCorrectLetter => _isCorrectLetter;
  Map<String, dynamic> get content => _vowels[_currentIndex];

  void toggleIsDrawMode() {
    _isDrawMode = !_isDrawMode;
    notifyListeners();
  }

  void drawingValidation(BuildContext context, String letter) {
    if (_vowels[currentIndex]["letter"] == letter) {
      _isCorrectLetter = true;

      Provider.of<ScoreProvider>(context, listen: false).incrementScore();

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
