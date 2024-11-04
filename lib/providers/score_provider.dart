import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreProvider extends ChangeNotifier {
  int _score = 0;

  // Getter for score
  int get score => _score;

  // Constructor to load score from SharedPreferences on initialization
  ScoreProvider() {
    _loadScore();
  }

  // Load score from SharedPreferences
  Future<void> _loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    _score = prefs.getInt('score') ?? 0;
    notifyListeners();
  }

  // Increment score and save to SharedPreferences
  Future<void> incrementScore() async {
    _score++;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', _score);
  }

  // Set score manually (if needed)
  // Future<void> setScore(int newScore) async {
  //   _score = newScore;
  //   notifyListeners();
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('score', _score);
  // }
}
