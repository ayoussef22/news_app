import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryColor=Color(0xff39A552);
  static ThemeData lightTheme=ThemeData(
    primaryColor:primaryColor ,
    appBarTheme: AppBarTheme(
      backgroundColor:primaryColor ,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        )
      )
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
    )
  );
}