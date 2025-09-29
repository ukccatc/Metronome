/// Locale provider for managing app language
/// Handles language switching and persistence

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  static const String _localeKey = 'app_locale';

  Locale _currentLocale = const Locale('en', '');

  Locale get currentLocale => _currentLocale;

  /// Initialize the provider and load saved locale
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocaleCode = prefs.getString(_localeKey);

    if (savedLocaleCode != null) {
      _currentLocale = Locale(savedLocaleCode);
      notifyListeners();
    }
  }

  /// Change the app locale
  Future<void> setLocale(Locale locale) async {
    if (_currentLocale == locale) return;

    _currentLocale = locale;
    notifyListeners();

    // Save to preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  /// Get supported locales
  static const List<Locale> supportedLocales = [
    Locale('en', ''), // English
    Locale('ru', ''), // Russian
  ];
}
