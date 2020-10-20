import "package:flutter/material.dart";
import 'package:projeto_3/assets_handler.dart';

class ThemeChanger with ChangeNotifier{
  ThemeData themeData = Themes.themed;

  ThemeChanger(this.themeData);

  getTheme() => themeData;

  setTheme(ThemeData theme){
    themeData = theme;

    notifyListeners();
  }
}

class Themes{

  static final ThemeData themel = ThemeData(
    primaryColor: Assets.blueColor,
    primaryColorDark: Assets.blueColor,
    visualDensity: VisualDensity.compact,
    brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Colors.red.shade900,
    ),
    canvasColor: Colors.transparent,

  );

  static final ThemeData themed = ThemeData(
      primaryColor: Colors.red,
      primaryColorDark: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
      ),
      buttonColor: Colors.red,
  );

}