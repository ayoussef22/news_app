import 'package:flutter/material.dart';
import 'package:news_app/MyTheme.dart';

class MyCategory{
  String id;
  String title;
  String imagePath;
  Color color;

  MyCategory({required this.id,required this.title,required this.imagePath,required this.color});

  static List<MyCategory> getCategories(){
    //
    return[
      MyCategory(id: 'sports', title: 'Sports', imagePath: 'assets/ball.png', color: MyTheme.redColor),
      MyCategory(id: 'general', title: 'General', imagePath: 'assets/Politics.png', color: MyTheme.darkBlueColor),
      MyCategory(id: 'health', title: 'Health', imagePath: 'assets/health.png', color: MyTheme.pinkColor),
      MyCategory(id: 'business', title: 'Business', imagePath: 'assets/bussines.png', color: MyTheme.lightBrownColor),
      MyCategory(id: 'entertainment', title: 'Entertainment', imagePath: 'assets/environment.png', color: MyTheme.lightBlueColor),
      MyCategory(id: 'science', title: 'Science', imagePath: 'assets/science.png', color: MyTheme.lightYellowColor),
      MyCategory(id: 'technology', title: 'Technology', imagePath: 'assets/technology.png', color: MyTheme.darkYellowColor),
    ];
  }
}
