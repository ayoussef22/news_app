import 'package:flutter/material.dart';
import 'package:news_app/API/ApiManger.dart';
import 'package:news_app/Model/SourceResponse.dart';

class CategoryDetailsViewModel extends ChangeNotifier{

  //todo: hold data and handle logic

  List <Source>? sourceList;
  String? errorMessage;
  
  void getSourcesByCategoryId(String categoryId)async{
    sourceList =null;
    errorMessage=null;
    notifyListeners();
    try{
      var response= await ApiManger.getSources(categoryId);
      if(response.status=='error'){
        errorMessage==response.message;
      } else{
        sourceList =response.sources;
        notifyListeners();
      }

    } catch(e){
      errorMessage = 'SomeThing Went Wrong Please Try Again ';
    }

  }
}