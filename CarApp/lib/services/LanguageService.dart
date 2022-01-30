import 'package:carapp/constants/Languages.dart';
import 'package:flutter/cupertino.dart';

class LanguageService extends ChangeNotifier {
  Locale? _locale;

  Locale get locale => _locale ?? const Locale('en');

  void setLocale(Locale locale)
  {
    _locale = locale;
    notifyListeners();
  }

  void clearLocale(Locale locale)
  {
    _locale = null;
    notifyListeners();
  }
}
