import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextService extends ChangeNotifier {
  Locale? _locale;
  Color? _fontColor;
  double? _fontSize;

  Locale get locale => _locale ?? const Locale('en');
  Color get fontColor => _fontColor ?? Colors.black;
  double get fontSize => _fontSize ?? 16;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }

  void setFontColor(Color color) {
    _fontColor = color;
    notifyListeners();
  }

  void clearFontColor() {
    _fontColor = null;
    notifyListeners();
  }

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }

  void clearFontSize() {
    _fontSize = null;
    notifyListeners();
  }
}
