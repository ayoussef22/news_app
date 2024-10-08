import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Category/cubit/CategoryDetailsViewModel.dart';
import 'package:news_app/Category/cubit/States.dart';
import 'package:news_app/Model/MyCategory.dart';
import 'package:news_app/Repository/Source/Repository/SourceRepositoryImpl.dart';
import 'package:news_app/Tabs/SourcesTabs.dart';

class CategoryDetails extends StatefulWidget {
  MyCategory category;

  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSourceByCategoryId(widget.category.id);
  }

  CategoryDetailsViewModel viewModel = CategoryDetailsViewModel(injectSourceRepository());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CategoryDetailsViewModel, SourceStates>(
            bloc: viewModel,
            builder: (context, state) {
              if (state is SourceLoadingState) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ));
              } else if (state is SourceErrorState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorMessage!),
                      ElevatedButton(
                          onPressed: () {
                            viewModel.getSourceByCategoryId(widget.category.id);
                          },
                          child: const Text('Try Again'))
                    ],
                  ),
                );
              } else if (state is SourceSuccessState) {
                return SourcesTabs(sourcesList: state.sourceList!);
              }
              return Container(); //un reachable
            }),

        // FutureBuilder<SourceResponse>(
        //   future: ApiManger.getSources(widget.category.id),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //           child: CircularProgressIndicator(
        //         color: Theme.of(context).primaryColor,
        //       ));
        //     } else if (snapshot.hasError) {
        //       return Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             const Text('Something Went Wrong'),
        //             ElevatedButton(
        //                 onPressed: () {
        //                   ApiManger.getSources(widget.category.id);
        //                   setState(() {});
        //                 },
        //                 child: const Text('Try Again'))
        //           ],
        //         ),
        //       );
        //     }
        //     // server has response
        //      if (snapshot.data?.status != 'ok') {
        //       return Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(snapshot.data?.message ?? 'Something Went Wrong'),
        //             ElevatedButton(
        //                 onPressed: () {
        //                   ApiManger.getSources(widget.category.id);
        //                   setState(() {});
        //                 },
        //                 child: const Text('Try Again'))
        //           ],
        //         ),
        //       );
        //     } else {
        //       var sourcesList = snapshot.data?.sources ?? [];
        //
        //       return SourcesTabs(sourcesList: sourcesList);
        //     }
        //   },
        // ),
      ),
    );
  }
}
