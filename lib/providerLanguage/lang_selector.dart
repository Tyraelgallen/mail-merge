import 'package:flutter/material.dart';
import 'package:mail_merge/providerLanguage/locale_provider.dart';

import 'package:provider/provider.dart';

class LanguageSelect extends StatefulWidget {
  @override
  _LanguageSelectState createState() => _LanguageSelectState();
}

class _LanguageSelectState extends State<LanguageSelect> {
  String _selectedLanguage = PrefsApp.lang;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedLanguage == 'es' ? Colors.blue : null,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = 'es';
                      provider.setLocale(const Locale('es'));
                      PrefsApp.lang = "es";
                    });
                  },
                  splashColor: _selectedLanguage == 'es'
                      ? Colors.blue
                      : Colors.transparent,
                  child: Center(
                    child: Text(
                      'Español',
                      style: TextStyle(
                        color: _selectedLanguage == 'es'
                            ? Colors.white
                            : Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedLanguage == 'en' ? Colors.blue : null,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = 'en';
                      provider.setLocale(const Locale('en'));
                      PrefsApp.lang = "en";
                    });
                  },
                  splashColor: _selectedLanguage == 'en'
                      ? Colors.blue
                      : Colors.transparent,
                  child: Center(
                    child: Text(
                      'English',
                      style: TextStyle(
                        color: _selectedLanguage == 'en'
                            ? Colors.white
                            : Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedLanguage == 'pt' ? Colors.blue : null,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = 'pt';
                      provider.setLocale(const Locale('pt'));
                      PrefsApp.lang = "pt";
                    });
                  },
                  splashColor: _selectedLanguage == 'pt'
                      ? Colors.blue
                      : Colors.transparent,
                  child: Center(
                    child: Text(
                      'Português',
                      style: TextStyle(
                        color: _selectedLanguage == 'pt'
                            ? Colors.white
                            : Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
