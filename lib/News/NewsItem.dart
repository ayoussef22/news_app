import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Model/NewsResponse.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:news_app/News/NewsDetails.dart';

class NewsItem extends StatelessWidget {
  News news;

  NewsItem({required this.news});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(NewsDetails.routeName,
        arguments:  news);
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: news.urlToImage ?? '',
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 10),
            Text(news.author ?? ''),
            const SizedBox(height: 10),
            Text(news.title ?? ''),
            const SizedBox(height: 10),
            Text(
              DateFormat.jm('en').format(DateTime.parse(news.publishedAt ?? '')),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
