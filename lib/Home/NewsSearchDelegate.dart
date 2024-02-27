import 'package:flutter/material.dart';
import 'package:news_app/MyTheme.dart';

import '../API/ApiManger.dart';
import '../Model/NewsResponse.dart';
import '../News/NewsItem.dart';

class NewsSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      return Stack(children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            'assets/background.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        FutureBuilder<NewsResponse>(
          future: ApiManger.searchResult(query ?? ''),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  const Text('SomeThing Went Wrong'),
                  ElevatedButton(
                      onPressed: () {
                        ApiManger.searchResult(query ?? "");
                      },
                      child: const Text('Try Again'))
                ],
              );
            }
            if (snapshot.data?.status != 'ok') {
              return Column(
                children: [
                  Text(snapshot.data?.message ?? 'SomeThing Went Wrong'),
                  ElevatedButton(
                      onPressed: () {
                        ApiManger.searchResult(query ?? "");
                      },
                      child: const Text('Try Again'))
                ],
              );
            }
            var newsList = snapshot.data?.articles ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                return NewsItem(news: newsList[index]);
              },
              itemCount: newsList.length,
            );
          },
        ),
      ]);
    } else {
      return Container(
        color: Colors.white,
        child: Image.asset(
          'assets/background.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: MyTheme.primaryColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
          borderSide: BorderSide.none,
        )));
  }
}
