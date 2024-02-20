import 'package:flutter/material.dart';
import 'package:news_app/ApiManger.dart';
import 'package:news_app/Model/SourceResponse.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName='category details';

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar:AppBar(
            title: Text('News App',style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white
            ),),
          ),
        body:  FutureBuilder<SourceResponse>(
          future: ApiManger.getSources(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(
                color:Theme.of(context).primaryColor ,));
            } else if(snapshot.hasError){
              return Column(
                children: [
                  Text('Something Went Wrong'),
                  ElevatedButton(onPressed: (){
                    ApiManger.getSources();
                    setState(() {});
                  },
                      child: Text('Try Again'))
                ],);
            }
            // server has response
            if(snapshot.data?.status !='ok'){
              return Column(
                children: [
                  Text(snapshot.data?.message??'Something Went Wrong'),
                  ElevatedButton(onPressed: (){
                    ApiManger.getSources();
                    setState(() {});
                  },
                      child: Text('Try Again'))
                ],);
            }
            var sourceList=snapshot.data?.sources??[];
            return ListView.builder(itemBuilder: (context, index) {
              return Text(sourceList[index].name??'');
            },itemCount: sourceList.length,
            );
          },
        ),
      ),
    );

  }
}
