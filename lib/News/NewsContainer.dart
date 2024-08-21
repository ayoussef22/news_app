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
  int page = 1;
  final ScrollController controller = ScrollController();
  List<News> news = [];
  bool nextPage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      if (controller.position.atEdge) {
        if (controller.offset != 0) {
          nextPage = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (nextPage) {
      ApiManger.getNewsFromSourcesId(
              sourceId: widget.source.id ?? '', page: ++page)
          .then((newsResponse) => news.addAll(newsResponse.articles ?? []));
      nextPage = false;
      setState(() {});
    }
    return FutureBuilder<NewsResponse>(
      future: ApiManger.getNewsFromSourcesId(sourceId: widget.source.id ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            news.isEmpty) {
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
                    ApiManger.getNewsFromSourcesId(
                        sourceId: widget.source.id ?? '');
                    setState(() {});
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
                    ApiManger.getNewsFromSourcesId(
                        sourceId: widget.source.id ?? '');
                    setState(() {});
                  },
                  child: const Text('Try Again'))
            ],
          );
        }
        var newsList = snapshot.data?.articles ?? [];
        if (news.isEmpty) {
          news = newsList;
        } else if (news.first.title != newsList.first.title) {
          news = newsList;
          controller.jumpTo(1);
        }

        return ListView.builder(
          controller: controller,
          itemBuilder: (context, index) {
            return NewsItem(news: news[index]);
          },
          itemCount: news.length,
        );
      },
    );
  }
}
