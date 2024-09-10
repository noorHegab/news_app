import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  Locale _locale = const Locale('en', '');
  String _lang = "en";

  Locale get locale => _locale;
  String get lang => _lang;

  void setLocale(BuildContext context, Locale newLocale) {
    _locale = newLocale;

    _lang = newLocale.languageCode;

    // تحديث لغة easy_localization
    EasyLocalization.of(context)!.setLocale(newLocale);

    notifyListeners();
  }
}
