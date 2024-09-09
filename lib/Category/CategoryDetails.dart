import 'package:flutter/material.dart';
import 'package:news_app/API/ApiManger.dart';
import 'package:news_app/Category/CategoryDetailsViewModel.dart';
import 'package:news_app/Model/MyCategory.dart';
import 'package:news_app/Model/SourceResponse.dart';
import 'package:news_app/Tabs/SourcesTabs.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  MyCategory category;

  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    viewModel.getSourcesByCategoryId(widget.category.id);
    // TODO: implement initState
    super.initState();
  }
  CategoryDetailsViewModel viewModel=CategoryDetailsViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context)=>viewModel,
          child: Consumer<CategoryDetailsViewModel>(
              builder: (context,viewModel,child){
                if(viewModel.errorMessage!=null){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(viewModel.errorMessage!),
                        ElevatedButton(onPressed: (){
                          viewModel.getSourcesByCategoryId(widget.category.id);
                        },
                            child: Text('Try Again'))
                      ],
                    ),
                  );
                }
                else if(viewModel.sourceList==null){
                  return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )
                  );
                } else{
                  return SourcesTabs(sourcesList: viewModel.sourceList!);
                }
              }
          ),
        )
        )
        );

  }
}

/*  FutureBuilder<SourceResponse>(
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
             if (snapshot.data?.status != 'ok') {
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
        ),*/


