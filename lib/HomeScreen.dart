import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
static const String routeName='home';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          title: Text('News App',style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white
          ),),
        )
      ),
    );
  }
}
