import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/NewsResponse.dart';
import '../../Repository/News/NewsRepositoryContract.dart';
import 'States.dart';

class NewsViewModel extends Cubit<NewsStates> {
  final NewsRepositoryContract repository;
  List<News> news = [];
  int page = 1;
  bool isLoadingMore = false;
  String currentSourceId = '';

  NewsViewModel(this.repository) : super(NewsLoadingState());

  void getNews({required String sourceId, bool refresh = false}) async {
    if (refresh || currentSourceId != sourceId) {
      news.clear();
      page = 1;
      currentSourceId = sourceId;
      emit(NewsLoadingState());
    }

    try {
      final response = await repository.getNews(sourceId: sourceId, page: page);
      if (response.articles != null && response.articles!.isNotEmpty) {
        news.addAll(response.articles!);
        emit(NewsSuccessState(newsList: news, hasMore: response.articles!.length == 20));
      } else if (news.isEmpty) {
        emit(NewsErrorState(errorMessage: 'No News For This source'));
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: 'Something Went Wrong , Try Again '));
    }
  }

  void loadNextPage() {
    if (isLoadingMore) return;
    isLoadingMore = true;
    page++;
    getNews(sourceId: currentSourceId);
    isLoadingMore = false;
  }
}
