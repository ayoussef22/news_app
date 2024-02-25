import 'package:flutter/material.dart';
import 'package:news_app/API/ApiManger.dart';
import 'package:news_app/Model/NewsResponse.dart';
import 'package:news_app/Model/SourceResponse.dart';
import 'package:news_app/News/NewsItem.dart';

class NewsContainer extends StatefulWidget {
  Source source;
  NewsContainer({required this.source});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse>(
        future: ApiManger.getNewsFromSourcesId(widget.source.id??''),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }else if(snapshot.hasError){
            return Column(
              children: [
              const Text('SomeThing Went Wrong'),
                ElevatedButton(onPressed: (){
                  ApiManger.getNewsFromSourcesId(widget.source.id??"");
                  setState(() {

                  });
                },
                    child: const Text('Try Again'))
            ],
            );
          }
          if(snapshot.data?.status !='ok'){
            return Column(
              children: [
                Text(snapshot.data?.message??'SomeThing Went Wrong'),
                ElevatedButton(onPressed: (){
                  ApiManger.getNewsFromSourcesId(widget.source.id??"");
                  setState(() {

                  });
                },
                    child: const Text('Try Again'))
              ],
            );
          }
          var newsList=snapshot.data?.articles??[];
          return ListView.builder(
              itemBuilder: (context, index) {
                return NewsItem(news: newsList[index]);
              },itemCount: newsList.length,);
        },);
  }
}
