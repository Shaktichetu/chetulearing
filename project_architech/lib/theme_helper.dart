import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_architech/theme_colors.dart';

class ThemeHelpers {
  static ThemeData lightTheme = ThemeData(
      primaryColor: ThemeColors.redColor,
      backgroundColor: ThemeColors.whiteColor,
      scaffoldBackgroundColor: ThemeColors.backgroundColor,
      appBarTheme: const AppBarTheme(
          color: ThemeColors.appThemeColor,
          iconTheme: IconThemeData(color: Colors.black,size: 30.0)
      ),
  );

  static MaterialColor atRedTypeColor = MaterialColor(
    _redColor, <int,Color>{
    50:Color(0xFFFCE4EC),
    100:Color(0xFFF8BBD0),
    200:Color(0xFFF48FB1),
    300:Color(0xFFF06292),
    400:Color(0xFFeC407A),
    500:Color(_redColor),
    600:Color(0xFFD81B60),
    700:Color(0xFFC2185B),
    800:Color(0xFFAD1457),
    900:Color(0xFF880E4F),

  },);
  static const int _redColor = 0xFFAF0947;
}

