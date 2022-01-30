import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextService extends ChangeNotifier {
  Locale? _locale;
  Color? _fontColor;
  double? _fontSize;

  Locale get locale => _getLocale();
  Locale _getLocale() {
    if (_locale == null) {
      _loadLocale();
    }
    return _locale ?? const Locale('en');
  }

  Color get fontColor => _getFontColor();
  Color _getFontColor() {
    if (_fontColor == null) {
      _loadFontColor();
    }
    return _fontColor ?? Colors.black;
  }

  double get fontSize => _getFontSize();
  double _getFontSize() {
    if (_fontSize == null) {
      _loadFontSize();
    }
    return _fontSize ?? 16;
  }

  void setLocale(Locale locale) {
    _locale = locale;
    _saveLocale(locale);
    notifyListeners();
  }

  void _saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', locale.languageCode);
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString('language') ?? 'en';
    _locale = Locale(locale);
    notifyListeners();
  }

  void setFontColor(Color color) {
    _fontColor = color;
    _saveFontColor(color);
    notifyListeners();
  }

  void _saveFontColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('fontColor', color.value);
  }

  void _loadFontColor() async {
    final prefs = await SharedPreferences.getInstance();
    final color = prefs.getInt('fontColor') ?? Colors.black.value;
    _fontColor = Color(color);
    notifyListeners();
  }

  void setFontSize(double size) {
    _fontSize = size;
    _saveFontSize(size);
    notifyListeners();
  }

  void _saveFontSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', size);
  }

  void _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final size = prefs.getDouble('fontSize') ?? 16;
    _fontSize = size;
    notifyListeners();
  }

  void setDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('fontSize');
    prefs.remove('fontColor');
    _fontColor = null;
    _fontSize = null;
    notifyListeners();
  }
}
