import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonHelpers {
  static const String TABLENAME = "todos";
  Map<String, dynamic> toMap() {
    return {'id': 2, 'title': "contentData"};
  }

  static var delegateTheme = Get.theme.copyWith(
      textTheme: Get.textTheme.copyWith(
          subtitle1: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.normal))),
      inputDecorationTheme: InputDecorationTheme(
          // enabledBorder: delegateSearchBorder,
          // disabledBorder: delegateSearchBorder,
          // focusedBorder: searchFieldBorder,
          border: textFieldBorder));
  static OutlineInputBorder textFieldBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static MaterialColor converttoMaterialColor({int targetColor = 0xffaf0947}) {
    Map<int, Color> color = {
      50: Color.fromRGBO(136, 14, 79, .1),
      100: Color.fromRGBO(136, 14, 79, .2),
      200: Color.fromRGBO(136, 14, 79, .3),
      300: Color.fromRGBO(136, 14, 79, .4),
      400: Color.fromRGBO(136, 14, 79, .5),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xffaf0947, color);
    return colorCustom;
  }
}
