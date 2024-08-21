import 'package:flutter/material.dart';
import 'package:news_app/Category/CategoryDetails.dart';
import 'package:news_app/Home/HomeScreen.dart';
import 'package:news_app/MyTheme.dart';
import 'package:news_app/News/NewsDetails.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        NewsDetails.routeName:(context)=>NewsDetails()
      },
      initialRoute: HomeScreen.routeName,
      theme: MyTheme.lightTheme,
    );
  }
}
