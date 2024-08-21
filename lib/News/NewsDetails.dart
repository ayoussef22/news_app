import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Model/NewsResponse.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';


class NewsDetails extends StatelessWidget {
static const String routeName='news details';
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    var news=ModalRoute.of(context)?.settings.arguments as News;
    return Stack(
      children:[
        Container(
          color: Colors.white,
          child: Image.asset(
            'assets/background.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
        appBar: AppBar(
          title:  Text(news.title??''),
        ),
        body: Padding(
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
              const SizedBox(height: 15),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white
                ),
                child: Text(news.description??''),
              ),

              const SizedBox(height: 25),
              InkWell(
                onTap:(){
                  _launchUrl(news.url??'');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  Text('View Full Article',style: Theme.of(context).textTheme.titleMedium,),
                  Icon(Icons.play_arrow_sharp)
                ],),
              )

            ],
          ),
        ),
      ),
    ]);
  }
Future<void> _launchUrl(String url) async {
    var uri=Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}
}
