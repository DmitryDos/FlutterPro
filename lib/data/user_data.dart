import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends ChangeNotifier {
  UserData._privateConstructor();

  static final UserData _instance = UserData._privateConstructor();

  static UserData get instance => _instance;

  int _swipes = 0;
  int _likes = 0;
  int _themeChanges = 0;
  bool _darkTheme = true;
  bool _isCardAnimated = true;
  String _selectedBackground = 'assets/backgrounds/ground0.jpg';

  String get swipes => _swipes.toString();
  String get likes => _likes.toString();
  String get themeChanges => _themeChanges.toString();
  bool get darkTheme => _darkTheme;
  bool get isCardAnimated => _isCardAnimated;
  String get selectedBackground => _selectedBackground;

  void toggleCardAnimation() {
    _isCardAnimated = !_isCardAnimated;
    _saveData();
    notifyListeners();
  }

  void toggleDarkTheme() {
    _darkTheme = !_darkTheme;
    _themeChanges++;
    _saveData();
    notifyListeners();
  }

  void setBackground(final String value) {
    _selectedBackground = value;
    _saveData();
    notifyListeners();
  }

  void incrementSwipes() {
    _swipes++;
    _saveData();
    notifyListeners();
  }

  void incrementLikes() {
    _likes++;
    _saveData();
    notifyListeners();
  }

  void resetStats() {
    _swipes = 0;
    _likes = 0;
    _themeChanges = 0;
    _saveData();
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('swipes', _swipes);
    await prefs.setInt('likes', _likes);
    await prefs.setInt('themeChanges', _themeChanges);
    await prefs.setBool('darkTheme', _darkTheme);
    await prefs.setBool('isCardAnimated', _isCardAnimated);
    await prefs.setString('selectedBackground', _selectedBackground);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _swipes = prefs.getInt('swipes') ?? 0;
    _likes = prefs.getInt('likes') ?? 0;
    _themeChanges = prefs.getInt('themeChanges') ?? 0;
    _darkTheme = prefs.getBool('darkTheme') ?? true;
    _isCardAnimated = prefs.getBool('isCardAnimated') ?? true;
    _selectedBackground = prefs.getString('selectedBackground') ??
        'assets/backgrounds/ground0.jpg';
    notifyListeners();
  }
}
