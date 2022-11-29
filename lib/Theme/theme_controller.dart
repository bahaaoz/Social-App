import 'package:flutter/material.dart';
import 'package:socialapp/main.dart';

class ThemeController extends ChangeNotifier {
  bool get theme {
    if (sharedPreferences!.getBool("theme") == null) {
      return true;
    }
    return sharedPreferences!.getBool("theme") as bool;
  }

  void changeTheme(bool currentTheme) {
    //bool temp = sharedPreferences!.getBool("theme") ?? false;
    sharedPreferences!.setBool("theme", currentTheme);
    notifyListeners();
  }
}
