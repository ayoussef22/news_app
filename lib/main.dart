import 'package:flutter/material.dart';
import 'package:news_app/CategoryDetails.dart';
import 'package:news_app/HomeScreen.dart';
import 'package:news_app/MyTheme.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        CategoryDetails.routeName:(context)=>CategoryDetails(),
      },
      initialRoute: CategoryDetails.routeName,
      theme: MyTheme.lightTheme,
    );
  }
}