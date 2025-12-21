import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Model/SourceResponse.dart';
import 'package:news_app/News/NewsItem.dart';
import '../Repository/News/Respository/NewsRepositoryImpl.dart';
import 'Cubit/NewsContainerViewModel.dart';
import 'Cubit/States.dart';

class NewsContainer extends StatefulWidget {
  final Source source;

  const NewsContainer({required this.source, Key? key}) : super(key: key);

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  late NewsViewModel viewModel;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    viewModel = NewsViewModel(injectNewsRepository());
    viewModel.getNews(sourceId: widget.source.id!);

    controller.addListener(() {
      // load next page when scroll near bottom
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 100) {
        viewModel.loadNextPage();
      }
    });
  }

  @override
  void didUpdateWidget(covariant NewsContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If User Changed The Source
    if (oldWidget.source.id != widget.source.id) {
      viewModel.getNews(sourceId: widget.source.id!, refresh: true);

      // reset scroll
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.hasClients && viewModel.news.isNotEmpty) {
          controller.jumpTo(0);
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsViewModel, NewsStates>(
      bloc: viewModel,
      builder: (context, state) {
        // Loading indicator
        if (state is NewsLoadingState && viewModel.news.isEmpty) {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor));
        }

        // Error or no news
        if (state is NewsErrorState && viewModel.news.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errorMessage),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () =>
                      viewModel.getNews(sourceId: widget.source.id!),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        // Success or already loaded news
        if (viewModel.news.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async =>
                viewModel.getNews(sourceId: widget.source.id!, refresh: true),
            child: ListView.builder(
              controller: controller,
              itemCount: viewModel.news.length,
              itemBuilder: (context, index) {
                return NewsItem(news: viewModel.news[index]);
              },
            ),
          );
        }

        // fallback
        return Container();
      },
    );
  }
}
