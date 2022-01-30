import 'dart:collection';

import 'package:carapp/constants/Language.dart';

class Languages {
  const Languages._();

  static final languages = [
    Language(code: 'en', value: 'English'),
    Language(code: 'ru', value: 'Русский'),
  ];

  static final Map<String, String> languageCode = {
    'English': 'en',
    'Русский': 'ru'
  };

  static final Map<String, String> languageValue = {
    'en': 'English',
    'ru': 'Русский'
  };
}
