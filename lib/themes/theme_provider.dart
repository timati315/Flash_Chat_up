import 'package:flash_chat_dubl_3/themes/dark_mode.dart';
import 'package:flash_chat_dubl_3/themes/light_mod.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darktMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void togleTheme() {
    if (_themeData == lightMode) {
      themeData = darktMode;
    } else {
      themeData = lightMode;
    }
  }
}
