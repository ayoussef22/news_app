import 'package:flutter/material.dart';
import 'package:news_app/API/ApiManger.dart';
import 'package:news_app/Model/MyCategory.dart';
import 'package:news_app/Model/SourceResponse.dart';
import 'package:news_app/Tabs/SourcesTabs.dart';

class CategoryDetails extends StatefulWidget {
  MyCategory category;

  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<SourceResponse>(
          future: ApiManger.getSources(widget.category.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something Went Wrong'),
                    ElevatedButton(
                        onPressed: () {
                          ApiManger.getSources(widget.category.id);
                          setState(() {});
                        },
                        child: const Text('Try Again'))
                  ],
                ),
              );
            }
            // server has response
            else if (snapshot.data?.status != 'ok') {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data?.message ?? 'Something Went Wrong'),
                    ElevatedButton(
                        onPressed: () {
                          ApiManger.getSources(widget.category.id);
                          setState(() {});
                        },
                        child: const Text('Try Again'))
                  ],
                ),
              );
            } else {
              var sourcesList = snapshot.data?.sources ?? [];

              return SourcesTabs(sourcesList: sourcesList);
            }
          },
        ),
      ),
    );
  }
}
