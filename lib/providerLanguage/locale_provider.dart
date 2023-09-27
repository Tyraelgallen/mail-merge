// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale(PrefsApp.lang);
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('es');
    notifyListeners();
  }
}

class PrefsApp {
  static late SharedPreferences _prefs;
  static String _lang = "en";

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get lang {
    return _prefs.getString('languageapp') ?? _lang;
  }

  static set lang(String value) {
    _lang = value;
    _prefs.setString('languageapp', value);
  }
}

class L10n {
  static final all = [
    const Locale('es'),
    const Locale('en'),
    const Locale('pt'),
  ];
}
